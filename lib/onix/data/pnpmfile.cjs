const fs = require('fs')
const path = require('path')

// Validate ONIX_PACKAGE_DIR at module load time
const packageDir = process.env.ONIX_PACKAGE_DIR
if (!packageDir) {
  throw new Error(
    'ONIX_PACKAGE_DIR environment variable not set. ' +
    'Run: ONIX_PACKAGE_DIR=$(nix-build ... -A packageDir --no-out-link) pnpm install --frozen-lockfile --config.global-pnpmfile=nix/pnpmfile.cjs'
  )
}

function readIntegrityFromManifest(storePath) {
  const manifestPath = path.join(storePath, '.onix-manifest')
  if (!fs.existsSync(manifestPath)) return null

  const content = fs.readFileSync(manifestPath, 'utf8')
  const firstLine = content.split('\n')[0]

  // Parse: #integrity sha512-...
  const match = firstLine.match(/^#integrity\s+(sha512-.+)$/)
  return match ? match[1] : null
}

function buildIndexes(packageDir) {
  const byIntegrity = new Map()  // sha512-... -> {storePath, pkgName}
  const byNameVersion = new Map() // express@4.21.2 -> {storePath, pkgName}

  const entries = fs.readdirSync(packageDir)

  for (const entryName of entries) {
    const entryPath = path.join(packageDir, entryName)
    const stats = fs.lstatSync(entryPath)

    if (stats.isDirectory() && entryName.startsWith('@')) {
      // Scoped package directory — walk one level deeper
      const scopePath = entryPath
      const scopedEntries = fs.readdirSync(scopePath)

      for (const scopedEntryName of scopedEntries) {
        const symlinkPath = path.join(scopePath, scopedEntryName)
        const scopedStats = fs.lstatSync(symlinkPath)

        if (!scopedStats.isSymbolicLink()) continue

        const storePath = fs.realpathSync(symlinkPath)

        // Extract package name and name@version
        // scopedEntryName is like "darwin-arm64@0.24.2"
        const pkgName = entryName + '/' + scopedEntryName.split('@')[0]
        const nameVersion = entryName + '/' + scopedEntryName

        // Read integrity from .onix-manifest
        const integrity = readIntegrityFromManifest(storePath)

        if (integrity) byIntegrity.set(integrity, { storePath, pkgName })
        byNameVersion.set(nameVersion, { storePath, pkgName })
      }
    } else if (stats.isSymbolicLink()) {
      // Top-level package
      const symlinkPath = entryPath
      const storePath = fs.realpathSync(symlinkPath)

      // Extract package name and name@version
      // entryName is like "express@4.21.2"
      const pkgName = entryName.split('@')[0]
      const nameVersion = entryName

      // Read integrity from .onix-manifest
      const integrity = readIntegrityFromManifest(storePath)

      if (integrity) byIntegrity.set(integrity, { storePath, pkgName })
      byNameVersion.set(nameVersion, { storePath, pkgName })
    }
  }

  return { byIntegrity, byNameVersion }
}

function buildFilesMap(storePath, pkgName) {
  const filesMap = new Map() // relPath -> absPath
  const pkgRoot = path.join(storePath, 'node_modules', pkgName)

  function walkDir(dir, relPath) {
    const entries = fs.readdirSync(dir, { withFileTypes: true })

    for (const entry of entries) {
      const absPath = path.join(dir, entry.name)
      const entryRelPath = relPath ? path.join(relPath, entry.name) : entry.name

      if (entry.isDirectory()) {
        // Skip build-time dependencies
        if (entry.name === 'node_modules' || entry.name === '.bin') continue
        walkDir(absPath, entryRelPath)
      } else if (entry.isFile()) {
        filesMap.set(entryRelPath, absPath)
      }
    }
  }

  walkDir(pkgRoot, '')
  return filesMap
}

function parseTarballUrl(tarball) {
  // Unscoped: https://registry.npmjs.org/express/-/express-4.21.2.tgz
  let match = tarball.match(/https:\/\/registry\.npmjs\.org\/([^/]+)\/-\/\1-(\d+\.\d+\.\d+.*?)\.tgz/)
  if (match) return `${match[1]}@${match[2]}`

  // Scoped: https://registry.npmjs.org/@types/node/-/node-22.13.1.tgz
  match = tarball.match(/https:\/\/registry\.npmjs\.org\/(@[^/]+\/[^/]+)\/-\/([^/]+)-(\d+\.\d+\.\d+.*?)\.tgz/)
  if (match) return `${match[1]}@${match[3]}`

  return null
}

// Build indexes at module load time
const { byIntegrity, byNameVersion } = buildIndexes(packageDir)

module.exports = {
  fetchers: [
    {
      canFetch(pkgId, resolution) {
        // Primary: check by integrity
        if (resolution.integrity && byIntegrity.has(resolution.integrity)) {
          return true
        }

        // Secondary: check by name@version
        if (byNameVersion.has(pkgId)) {
          return true
        }

        return false
      },

      fetch(cafs, resolution, opts, fetchers) {
        // Lookup by integrity (primary)
        let pkgInfo = null
        if (resolution.integrity) {
          pkgInfo = byIntegrity.get(resolution.integrity)
        }

        // Fallback: parse tarball URL if integrity lookup fails
        if (!pkgInfo && resolution.tarball) {
          const nameVersion = parseTarballUrl(resolution.tarball)
          if (nameVersion) {
            pkgInfo = byNameVersion.get(nameVersion)
          }
        }

        // Not in Nix store — fall back to standard fetcher
        if (!pkgInfo) {
          return fetchers.remoteTarball(cafs, resolution, opts)
        }

        // Build filesMap and read manifest
        const { storePath, pkgName } = pkgInfo
        const filesMap = buildFilesMap(storePath, pkgName)
        const pkgRoot = path.join(storePath, 'node_modules', pkgName)
        const manifest = JSON.parse(
          fs.readFileSync(path.join(pkgRoot, 'package.json'), 'utf8')
        )

        return {
          filesMap,
          manifest,
          requiresBuild: false
        }
      }
    }
  ]
}
