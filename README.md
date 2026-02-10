# onix

Hermetic Nix packages from language-specific lockfiles. Import a lockfile, build every package once, cache forever.

Currently supports **Ruby** (Gemfile.lock). **npm** (package-lock.json) is planned.

```
$ onix import ~/src/rails     # read Gemfile.lock, generate nix package list
$ onix import ~/src/shopify   # import as many projects as you want
$ onix fetch                  # download packages, unpack sources
$ onix generate               # emit one nix derivation per package
$ onix build                  # build everything, cache forever
```

## Why

Language package managers (Bundler, npm, pip) solve dependency resolution but not hermetic builds. Nix solves hermetic builds but doesn't understand lockfiles. onix bridges them:

- **Lockfile in, nix derivations out.** Your existing `Gemfile.lock` (or soon `package-lock.json`) becomes the source of truth.
- **System libraries only.** Native extensions link against nixpkgs. No vendored copies of openssl, libxml2, sqlite, etc.
- **One derivation per package.** Individually cacheable, parallel builds, content-addressed store paths.
- **Build once, cache forever.** Same lockfile + same nixpkgs = same store paths. CI and dev machines share the cache.

## Install

```bash
gem install specific_install
gem specific_install https://github.com/tobi/onix
```

Requires Ruby ≥ 3.1 and Nix.

## Workflow

### 1. Initialize a project

```bash
mkdir my-packages && cd my-packages
onix init
```

Creates the directory structure: `cache/`, `nix/`, `overlays/`, `packagesets/`.

### 2. Import a lockfile

```bash
onix import ~/src/myapp              # reads myapp/Gemfile.lock
onix import --name blog Gemfile.lock  # explicit name
```

The packageset file is a copy of your lockfile stored in `packagesets/`. For Ruby, this is a `Gemfile.lock` saved as `<name>.gem`. Also generates `nix/app/<name>.nix` (the package list for Nix).

### 3. Fetch sources

```bash
onix fetch        # default: 20 parallel jobs
onix fetch -j 8   # fewer jobs
```

Downloads packages, unpacks sources, extracts metadata, clones git repos. Everything goes into `cache/` — no network access needed after this step.

### 4. Generate derivations

```bash
onix generate
```

Scans cached sources and metadata, auto-detects native dependencies from `extconf.rb`, and writes:
- `nix/gem/<name>/<version>/default.nix` — one derivation per package
- `nix/gem/<name>/default.nix` — version selector
- `nix/modules/gem.nix` — catalogue of all packages

### 5. Build

```bash
onix build                    # build every package in the pool
onix build myapp              # build all packages for one app
onix build myapp nokogiri     # build a single package from an app
onix build --gem nokogiri     # build by name (latest version)
onix build -k                 # keep going past failures
```

Shows live progress during builds (pipes through [nix-output-monitor](https://github.com/maralorn/nix-output-monitor) if available). On failure, prints the package name, the derivation path, and whether to create or edit an overlay:

```
  ✗ sqlite3  →  create overlays/sqlite3.nix
    nix log /nix/store/...-sqlite3-2.8.0.drv
    /path/to/nix/gem/sqlite3/2.8.0/default.nix
```

### 6. Check

```bash
onix check                        # all checks
onix check symlinks dep-completeness  # specific ones
```

Checks: `symlinks` · `nix-eval` · `source-clean` · `secrets` · `dep-completeness` · `require-paths-vs-metadata`. All run in parallel, results stream as they complete.

## Using built packages

`resolve` is the Nix-side API. Pass it `pkgs`, `ruby`, and a config — it returns an attrset with:

| Key | Type | Description |
|-----|------|-------------|
| `<gem-name>` | derivation | Individual package outputs |
| `bundlePath` | derivation | All packages merged into a single `BUNDLE_PATH` via `buildEnv` |
| `devShell` | function | `mkShell` wrapper that sets `BUNDLE_PATH`, `BUNDLE_GEMFILE`, and includes `ruby` |

### devShell (recommended)

The simplest way to use onix. Handles all plumbing automatically:

```nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  resolve = import ./nix/modules/resolve.nix;
  gems = resolve {
    inherit pkgs ruby;
    config = { onix.apps.rails.enable = true; };
  };
in gems.devShell {
  buildInputs = with pkgs; [ sqlite postgresql ];
}
```

### bundlePath

For CI scripts, Docker images, or custom derivations:

```nix
gems.bundlePath        # → /nix/store/...-onix-bundle
                       # contains ruby/3.4.0/gems/*, specifications/*, extensions/*
```

## Overlays

Most packages build automatically — `generate` scans `extconf.rb` and inlines detected `pkg_config`, `find_library`, and `have_header` calls as nixpkgs deps. It also detects Rust extensions using `rb_sys`.

When auto-detection isn't enough, write an overlay in `overlays/<package>.nix`. **Manual overlays always win** over auto-detection.

### System library deps

```nix
# overlays/pg.nix
{ pkgs, ruby }: with pkgs; [ libpq pkg-config ]
```

### System library flags

Force packages to use system libraries instead of vendored copies:

```nix
# overlays/sqlite3.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

### Build-time dependencies

Some packages need other packages during build. Use `buildGems` — the framework constructs `GEM_PATH` automatically:

```nix
# overlays/nokogiri.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [
    (pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; })
  ];
}
```

### Rust extensions

```nix
# overlays/tiktoken_ruby.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ rustc cargo libclang ];
  buildGems = [
    (pkgs.callPackage ../nix/gem/rb_sys/0.9.124 { inherit ruby; })
  ];
  beforeBuild = ''
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
  '';
}
```

### Lifecycle hooks

| Field | Type | Effect |
|-------|------|--------|
| `deps` | list | Added to `nativeBuildInputs` |
| `extconfFlags` | string | Appended to `ruby extconf.rb` |
| `buildGems` | list | Derivations needed at build time (auto `GEM_PATH`) |
| `beforeBuild` | string | Runs before the default build phase |
| `afterBuild` | string | Runs after `make` |
| `buildPhase` | string | **Replaces** the default build entirely |
| `postInstall` | string | Runs after install (`$dest` available) |

### Skip a package

```nix
# overlays/therubyracer.nix — abandoned
{ pkgs, ruby }: { buildPhase = "true"; }
```

## Packageset formats

Packagesets live in `packagesets/` and are copies of language-specific lockfiles. The file extension determines the ecosystem:

| Extension | Ecosystem | Lockfile source |
|-----------|-----------|----------------|
| `.gem` | Ruby | `Gemfile.lock` |
| `.npm` | Node.js | `package-lock.json` *(planned)* |

Each ecosystem has its own fetcher, source layout, and build strategy, but they share the same overlay system and nix output structure.

## Directory structure

```
my-packages/
├── packagesets/      # Lockfile copies (one per project, extension per ecosystem)
│   ├── rails.gem     # Ruby packageset (Gemfile.lock)
│   └── vite.npm      # Node packageset (package-lock.json) — planned
├── overlays/         # Hand-written build overrides
├── cache/
│   ├── sources/      # Unpacked source trees
│   ├── meta/         # Package metadata (JSON)
│   ├── gems/         # Downloaded .gem files
│   └── git-clones/   # Bare git clones
└── nix/              # Generated — never edit by hand
    ├── gem/          # Per-package derivations + version selectors
    ├── app/          # Per-project package lists
    └── modules/      # Catalogue, resolver, app registry
```

## Design principles

- **Everything local.** `fetch` downloads all sources ahead of time. Nix builds use `builtins.path` only — no network, no `fetchGit`, no `fetchurl`.
- **System libraries only.** Native packages link against nixpkgs. Vendored copies are stripped.
- **Lockfile is the source of truth.** Packageset files are unmodified copies, parsed by the ecosystem's own parser.
- **One derivation per package.** Individually cacheable, parallel builds, content-addressed store paths.
- **Auto-detect where possible, overlay where not.** Source analysis inlines common deps. Overlays handle the rest.
- **Manual overlays always win** over auto-detection.
- **Parameterized runtime.** `ruby` (or `nodejs`) flows through every derivation — one argument changes the whole build.
- **Ecosystem-agnostic core.** The overlay system, nix output layout, build/check/fetch commands work across ecosystems. Only the parser and materializer are ecosystem-specific.
