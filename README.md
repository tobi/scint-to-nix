# gem2nix

Turn a Ruby app's `Gemfile.lock` into hermetic, individually-cacheable Nix derivations — one per gem. The output is a `BUNDLE_PATH`-compatible directory that `require "bundler/setup"` accepts without modification.

Native extensions are compiled from source inside the Nix sandbox. No bundler install step, no network access, fully reproducible.

**Fizzy (Rails 8.2, 161 gems): 1026 tests, 4011 assertions, 0 errors.**

## Layout

```
nix/
├── gem/                                    # shared gem pool — one directory per gem
│   ├── rack/
│   │   ├── default.nix                     # selector — pick version or git rev
│   │   ├── 2.2.21/default.nix             # version derivation
│   │   ├── 3.2.3/default.nix
│   │   └── 3.2.4/default.nix
│   ├── rails/
│   │   ├── default.nix                     # selector (versions + git revs)
│   │   ├── 7.1.5.2/default.nix
│   │   └── git-60d92e4e7dfe/default.nix   # git repo derivation
│   └── ...                                 # 532 gems total
│
├── app/                                    # per-project gemset configs (pure data)
│   ├── fizzy.nix                           # list of { name; version; } entries
│   └── liquid.nix
│
├── modules/
│   ├── gem.nix                             # catalogue — all gems as callables
│   └── resolve.nix                         # config → derivations resolver
│
overlays/                                   # native build deps (hand-maintained)
├── nokogiri.nix
├── sqlite3.nix
├── ffi.nix
└── ...
```

Everything under `nix/` is generated. Never hand-edit — run `bin/generate` and `bin/generate-gemset` to regenerate. Customization lives in `overlays/`.

## App gemset configs

A gemset config is a plain Nix list — pure data, no functions, no `pkgs` or `ruby` arguments:

```nix
# nix/app/fizzy.nix (generated from Gemfile.lock)
[
  { name = "rack"; version = "3.2.4"; }
  { name = "nokogiri"; version = "1.19.0"; }
  { name = "zeitwerk"; version = "2.7.4"; }
  # ...
  # git: rails @ 60d92e4e7dfe
  { name = "rails"; git.rev = "60d92e4e7dfe"; }
]
```

The resolver (`nix/modules/resolve.nix`) turns a config into built derivations:

```nix
resolve = import ./nix/modules/resolve.nix;
gems = resolve { inherit pkgs ruby; gemset = import ./nix/app/fizzy.nix; };
# gems is an attrset: { rack = <drv>; nokogiri = <drv>; rails-60d92e4e7dfe = <drv>; ... }
```

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

## Devshell

```nix
# tests/fizzy/devshell.nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = import ../../nix/app/fizzy.nix; };
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
nix-shell ../gem2nix/tests/fizzy/devshell.nix
bundle exec rails test  # 1026 tests, 0 errors
```

## Quick start

```bash
# 1. Fetch gems into cache (rubygems + git sources)
bin/fetch

# 2. Generate per-gem derivations + selectors
bin/generate

# 3. Generate app gemset config from a Gemfile.lock
bin/generate-gemset fizzy ../fizzy/Gemfile.lock

# 4. Build all gems in the pool
just build

# 5. Build gems for one app
just build fizzy

# 6. Run lints
just lint fizzy

# 7. Enter devshell
cd ../fizzy && nix-shell ../gem2nix/tests/fizzy/devshell.nix
```

## Justfile commands

| Command | Purpose |
|---------|---------|
| `just build` | Build every gem derivation in the pool |
| `just build fizzy` | Build all gems for an app |
| `just build-gem fizzy rack` | Build a single gem (for debugging) |
| `just fetch` | Fetch gems into `cache/` |
| `just generate` | Regenerate all gem derivations + selectors |
| `just generate-gemset fizzy path/to/Gemfile.lock` | Generate app gemset config |
| `just regenerate fizzy path/to/Gemfile.lock` | Full pipeline: generate + gemset |
| `just test fizzy` | Run app test suite in devshell |
| `just lint fizzy` | Run lint suite |
| `just fmt-check` | Verify nix files pass nixfmt |

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

Current overlays: `extralite-bundle`, `ffi`, `libv8-node`, `mini_racer`, `mittens`, `nokogiri`, `openssl`, `pg`, `psych`, `puma`, `sqlite3`, `tiktoken_ruby`, `tokenizers`, `trilogy`.

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
just lint fizzy   # 8 passed, 0 failed
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
| Liquid | 44 | ✅ 973 tests, 0 errors |

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
     ├── bin/generate-gemset  Gemfile.lock → nix/app/<project>.nix (config list)
     │                                     → nix/gem/<repo>/git-<rev>/default.nix
     │
     │   nix/modules/resolve.nix   config list + pkgs + ruby → attrset of derivations
     │
     └── nix-build            each gem → /nix/store/<hash>-<gem>-<ver>/
                              buildEnv → unified BUNDLE_PATH
```

All generated nix files pass `nixfmt --check`. Regeneration is idempotent and safe — the entire `nix/` tree is disposable.
