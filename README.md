# scint-to-nix

Turn a Ruby app's `Gemfile.lock` into hermetic, individually-cacheable Nix derivations — one per gem. The output is a `BUNDLE_PATH`-compatible directory that `require "bundler/setup"` accepts without modification.

Native extensions are compiled from source inside the Nix sandbox. No bundler install step, no network access, fully reproducible.

**Fizzy (Rails 8.2, 161 gems): 1026 tests, 4011 assertions, 0 errors.**

## Layout

```
nix/
├── gem/                                    # one directory per gem
│   ├── rack/
│   │   ├── default.nix                     # selector — pick version or git rev
│   │   ├── 2.2.21/default.nix             # version derivation
│   │   ├── 3.2.3/default.nix
│   │   └── 3.2.4/default.nix
│   ├── rails/
│   │   ├── default.nix                     # selector (versions + git revs)
│   │   ├── 7.1.5.2/default.nix
│   │   └── git-60d92e4e7dfe/default.nix   # git repo derivation
│   └── ...                                 # 524 gems total
│
├── app/                                    # per-project gemsets
│   ├── fizzy.nix                           # 161 gems from fizzy's Gemfile.lock
│   └── chatwoot.nix
│
├── modules/
│   └── gem.nix                             # catalogue — all 524 gems as callables
│
overlays/                                   # native build deps (hand-maintained)
├── nokogiri.nix
├── sqlite3.nix
├── ffi.nix
└── ...
```

Everything under `nix/` is generated. Never hand-edit — run `bin/generate` and `bin/generate-gemset` to regenerate. Customization lives in `overlays/`.

## Gem selectors

Each gem has a `default.nix` that selects between available versions and git revs:

```nix
# nix/gem/rails/default.nix (generated)
{
  lib, stdenv, ruby,
  version ? "7.1.5.2",
  git ? { },
}: ...
```

Use it:

```nix
# Pick a rubygems version
gems.rails { version = "7.1.5.2"; }

# Pick a git rev
gems.rails { git.rev = "60d92e4e7dfe"; }

# Latest (default)
gems.rack { }
```

## App gemsets

A gemset wires up the exact versions from a `Gemfile.lock`:

```nix
# nix/app/fizzy.nix (generated from Gemfile.lock)
{ pkgs, ruby }:
let
  inherit (pkgs) lib stdenv;
  gem = name: args: pkgs.callPackage (../gem + "/${name}") ({ inherit lib stdenv ruby; } // args);
in
{
  "rack" = gem "rack" { version = "3.2.4"; };
  "rails-60d92e4e7dfe" = gem "rails" { git.rev = "60d92e4e7dfe"; };
  "nokogiri" = gem "nokogiri" { version = "1.19.0"; pkgs = pkgs; };
  # ... 161 gems
}
```

Overlay gems (like nokogiri) get `pkgs` passed through so they can access native build dependencies.

## Devshell

```nix
# tests/fizzy/devshell.nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  gems = import ../../nix/app/fizzy.nix { inherit pkgs ruby; };
  bundlePath = pkgs.buildEnv {
    name = "fizzy-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  buildInputs = [ ruby pkgs.sqlite pkgs.vips ];
  shellHook = ''
    export BUNDLE_PATH="${bundlePath}"
    export BUNDLE_GEMFILE="$PWD/Gemfile"
  '';
}
```

```bash
cd fizzy
nix-shell ../scint-to-nix/tests/fizzy/devshell.nix
bundle exec rails test  # 1026 tests, 0 errors
```

## Quick start

```bash
# 1. Fetch gems into cache (rubygems + git sources)
bin/fetch

# 2. Generate per-gem derivations + selectors
bin/generate

# 3. Generate app gemset from a Gemfile.lock
bin/generate-gemset fizzy ../fizzy/Gemfile.lock

# 4. Build all gems
bin/build

# 5. Run lints
tests/lint/run-all fizzy

# 6. Enter devshell
cd ../fizzy && nix-shell ../scint-to-nix/tests/fizzy/devshell.nix
```

## Scripts

| Script | Purpose |
|--------|---------|
| `bin/fetch` | Fetch gems from rubygems + git into `cache/` |
| `bin/generate` | Generate `nix/gem/*/default.nix` from `cache/meta/*.json` |
| `bin/generate-gemset` | Generate `nix/app/<project>.nix` from `Gemfile.lock` |
| `bin/build` | Parallel dependency-ordered `nix-build` of all gems |
| `bin/test-bundle` | Smoke test: build bundle-path, verify `bundler/setup` |
| `bin/lockfile-to-gems` | Convert `Gemfile.lock` to `.gems` manifest format |

## Overlays

Native build dependencies live in `overlays/<gem>.nix`. These are the only hand-maintained files:

```nix
# overlays/nokogiri.nix
{ pkgs, ruby }:
let
  mini_portile2 = pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; };
in {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  buildPhase = ''
    export GEM_PATH=${mini_portile2}/${mini_portile2.prefix}
    cd ext/nokogiri
    ruby extconf.rb --use-system-libraries
    make -j$NIX_BUILD_CORES
    cd ../..
    mkdir -p lib/nokogiri
    cp ext/nokogiri/nokogiri.so lib/nokogiri/
  '';
}
```

Current overlays: `ffi`, `mittens`, `nokogiri`, `openssl`, `pg`, `psych`, `puma`, `sqlite3`, `trilogy`.

## Bundle-path layout

The merged `buildEnv` output matches what `bundler/setup` expects:

```
$BUNDLE_PATH/
  ruby/3.4.0/
    gems/
      rack-3.2.4/
      sqlite3-2.8.0/
      sqlite3-2.8.0-x86_64-linux-gnu -> sqlite3-2.8.0   # platform alias
    specifications/
      rack-3.2.4.gemspec
      sqlite3-2.8.0.gemspec
      sqlite3-2.8.0-x86_64-linux-gnu.gemspec             # platform gemspec
    extensions/x86_64-linux/3.4.0/
      sqlite3-2.8.0/*.so
    bundler/gems/
      rails-60d92e4e7dfe/                                # git checkout
      useragent-433ca320a42d/
```

Platform-only gems (ffi, nokogiri, sqlite3) get symlinks and platform-qualified gemspecs so bundler finds them under their arch-specific names.

## Lint suite

```bash
tests/lint/run-all fizzy   # 8 passed, 0 failed
```

| Lint | Checks |
|------|--------|
| `nix-eval` | All `.nix` files parse |
| `dep-completeness` | Every lockfile dep has a derivation |
| `source-clean` | No pre-built `.so` leaked into sources |
| `require-paths-vs-gem-metadata` | Generated require_paths match `.gem` metadata |
| `gemspec-deps` | Gemspec deps resolve within the gemset |
| `require-paths` | Every require_path directory exists on disk |
| `native-extensions` | Native gems have compiled `.so` files |
| `loadable` | Key gems can be `require`'d in nix ruby |

## Tested projects

| Project | Gems | Status |
|---------|-----:|--------|
| Fizzy (Rails 8.2) | 161 | ✅ 1026 tests, 0 errors |
| Chatwoot (Rails 7.1) | 364 | ✅ 757 specs, 0 failures |
| Discourse | 296 | ✅ builds |

## How it works

```
Gemfile.lock
     │
     ├── bin/fetch           gem fetch + git clone → cache/
     │
     ├── bin/generate         cache/meta/*.json → nix/gem/*/default.nix
     │                                          → nix/gem/*/default.nix (selectors)
     │                                          → nix/modules/gem.nix (catalogue)
     │
     ├── bin/generate-gemset  Gemfile.lock → nix/app/<project>.nix
     │                                     → nix/gem/<repo>/git-<rev>/default.nix
     │
     └── nix-build            each gem → /nix/store/<hash>-<gem>-<ver>/
                              buildEnv → unified BUNDLE_PATH
```

All generated nix files pass `nixfmt --check`. Regeneration is idempotent and safe — the entire `nix/` tree is disposable.
