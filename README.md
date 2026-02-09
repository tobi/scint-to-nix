# gemset2nix

Turn any Ruby app's `Gemfile.lock` into hermetic, individually-cacheable Nix derivations — one per gem — producing a `BUNDLE_PATH` that `require "bundler/setup"` accepts without modification.

Native extensions compile from source inside the Nix sandbox. No `bundle install`, no network access at build time, fully reproducible across machines.

**1,413 gems × 3,786 versions × 5 Ruby versions (3.1–4.0) — all from one `Gemfile.lock`.**

```
$ just matrix fizzy
Building fizzy across all rubies...
  ruby_3_1.fizzy... /nix/store/...-fizzy-ruby_3_1
  ruby_3_2.fizzy... /nix/store/...-fizzy-ruby_3_2
  ruby_3_3.fizzy... /nix/store/...-fizzy-ruby_3_3
  ruby_3_4.fizzy... /nix/store/...-fizzy-ruby_3_4
  ruby_4_0.fizzy... /nix/store/...-fizzy-ruby_4_0
```

## Quick start

```bash
# Import a project — reads Gemfile.lock, writes gemset + nix config
bin/import fizzy ~/src/fizzy/Gemfile.lock

# Fetch all gem sources into cache/
bin/fetch

# Generate per-gem Nix derivations from cache
bin/generate

# Build everything
just build fizzy

# Enter devshell
cd ~/src/fizzy
nix-shell path/to/gemset2nix/tests/fizzy/devshell.nix
bundle exec rails test   # 1026 tests, 0 errors
```

## How it works

```
Gemfile.lock
     │
     ├─ bin/import ──────→ imports/fizzy.gemset     (gem manifest for fetching)
     │                   → nix/app/fizzy.nix        (gemset config — pure data list)
     │                   → nix/gem/*/git-*/         (git repo derivations)
     │
     ├─ bin/fetch ───────→ cache/gems/              (.gem files)
     │                   → cache/sources/           (unpacked source trees)
     │                   → cache/meta/              (extracted metadata JSON)
     │
     ├─ bin/generate ────→ nix/gem/<name>/<ver>/    (per-gem derivations)
     │                   → nix/gem/<name>/          (version selectors)
     │                   → nix/modules/gem.nix      (catalogue of all gems)
     │
     └─ nix-build ───────→ /nix/store/<hash>-<gem>/ (one store path per gem)
                         → buildEnv merges them into unified BUNDLE_PATH
```

Git gems use `builtins.fetchGit` — nix fetches the repo at eval time, pinned to the exact commit. No pre-cloning required.

## Architecture

### Three-tier layout

```
nix/
├── gem/                          # 1,413 gems — the shared pool
│   ├── rack/
│   │   ├── default.nix           # selector: pick version or git rev
│   │   ├── 3.2.3/default.nix    # standalone derivation
│   │   └── 3.2.4/default.nix
│   ├── rails/
│   │   ├── default.nix           # selector (versions + git revs)
│   │   ├── 8.1.2/default.nix
│   │   └── git-60d92e4e7dfe/    # git repo at pinned commit
│   └── ...
│
├── app/                          # per-project gemset configs (pure data)
│   ├── fizzy.nix                 # [ { name = "rack"; version = "3.2.4"; } ... ]
│   └── liquid.nix
│
├── modules/
│   ├── resolve.nix               # gemset list → attrset of built derivations
│   └── gem.nix                   # catalogue of all gem selectors
│
├── matrix.nix                    # ruby version × app build matrix
└── ruby4.nix                     # Ruby 4.0.1 (until nixpkgs ships it)

overlays/                         # native build customization (hand-maintained)
├── nokogiri.nix                  # system libxml2/libxslt
├── sqlite3.nix                   # system sqlite
├── pg.nix                        # system libpq
└── ...                           # 32 overlays total

imports/                          # gem manifests (for bin/fetch)
├── fizzy.gemset
├── chatwoot.gemset
└── ...                           # 11 projects
```

Everything under `nix/` is generated and checked into git. Never hand-edit — regenerate with `bin/generate`. Customization lives exclusively in `overlays/`.

### Gemset configs

A gemset is a plain Nix list — pure data, no functions:

```nix
# nix/app/fizzy.nix
[
  { name = "rack"; version = "3.2.4"; }
  { name = "nokogiri"; version = "1.19.0"; }
  { name = "zeitwerk"; version = "2.7.4"; }
  # git: rails @ 60d92e4e7dfe
  {
    name = "rails";
    git = {
      rev = "60d92e4e7dfe";
      url = "https://github.com/rails/rails.git";
      branch = "main";
    };
  }
]
```

### Resolver

The resolver turns a gemset config into built derivations:

```nix
resolve = import ./nix/modules/resolve.nix;
gems = resolve { inherit pkgs ruby; gemset = import ./nix/app/fizzy.nix; };
# → { rack = «derivation»; nokogiri = «derivation»; rails-60d92e4e7dfe = «derivation»; ... }
```

Nix's lazy evaluation means only gems in the gemset are built — the other 1,400+ in the pool are never touched.

### Devshell

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

The `ruby` parameter makes it trivial to test across versions:

```bash
nix-shell devshell.nix --arg ruby 'pkgs.ruby_3_3'
```

## Ruby version matrix

Build any app across all available Ruby versions:

```bash
just matrix fizzy              # all rubies (3.1, 3.2, 3.3, 3.4, 4.0)
just matrix fizzy ruby_3_3     # single ruby
just matrix                    # full matrix: all rubies × all apps
```

Or use `nix-build` directly:

```bash
nix-build nix/matrix.nix -A ruby_3_4.fizzy
nix-build nix/matrix.nix -A ruby_4_0
nix-build nix/matrix.nix                      # everything
```

Ruby 4.0.1 is packaged in `nix/ruby4.nix` using nixpkgs' `mkRuby`. It'll be replaced by `pkgs.ruby_4_0` once upstream ships it.

## Bundle-path layout

The merged output matches what `bundler/setup` expects:

```
$BUNDLE_PATH/ruby/3.4.0/
├── gems/
│   ├── rack-3.2.4/
│   ├── sqlite3-2.8.0/
│   └── sqlite3-2.8.0-x86_64-linux-gnu → sqlite3-2.8.0
├── specifications/
│   ├── rack-3.2.4.gemspec
│   ├── sqlite3-2.8.0.gemspec
│   └── sqlite3-2.8.0-x86_64-linux-gnu.gemspec
├── extensions/x86_64-linux/3.4.0/
│   └── sqlite3-2.8.0/sqlite3.so
└── bundler/gems/
    ├── rails-60d92e4e7dfe/
    └── useragent-433ca320a42d/
```

Native gems get platform symlinks and platform-qualified gemspecs so bundler finds them under arch-specific names.

## Overlays

Native build dependencies live in `overlays/<gem>.nix` — the only hand-maintained files. An overlay is a function `{ pkgs, ruby }:` returning deps and build hooks:

```nix
# overlays/sqlite3.nix — system sqlite via pkg-config
{ pkgs, ruby }:
{
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

```nix
# overlays/nokogiri.nix — system libxml2/libxslt + build-time gem dep
{ pkgs, ruby }:
let
  mini_portile2 = pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; };
in {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  beforeBuild = ''
    export GEM_PATH=${mini_portile2}/${mini_portile2.prefix}
  '';
}
```

### Overlay contract

| Field | Type | Effect |
|-------|------|--------|
| `deps` | `[ derivation ]` | Added to `nativeBuildInputs` |
| `extconfFlags` | `string` | Passed to `ruby extconf.rb $extconfFlags` |
| `beforeBuild` | `string` | Shell commands before `extconf.rb && make` |
| `afterBuild` | `string` | Shell commands after `make` |
| `postInstall` | `string` | Shell commands after install (`$dest` = output prefix) |
| `buildPhase` | `string` | **Replaces** the entire default build (escape hatch) |

Hooks compose with the default build phase. `buildPhase` is the escape hatch that replaces it entirely. A list return is shorthand for deps-only: `{ pkgs, ruby }: [ pkgs.openssl ]`.

**Rule: always link against system libraries from nixpkgs.** Never use vendored/bundled copies. Use `--use-system-libraries`, `--enable-system-libraries`, or provide paths via pkg-config.

### Current overlays (32)

`charlock_holmes` `commonmarker` `debase` `extralite-bundle` `ffi` `ffi-yajl` `field_test` `google-protobuf` `gpgme` `hiredis` `hiredis-client` `idn-ruby` `libv8` `libv8-node` `libxml-ruby` `mini_racer` `mittens` `mysql2` `nokogiri` `openssl` `pg` `psych` `puma` `rmagick` `rpam2` `rugged` `sqlite3` `therubyracer` `tiktoken_ruby` `tokenizers` `trilogy` `zlib`

## Commands

### Justfile

```bash
just build                     # build every gem derivation (3,786)
just build fizzy               # build gems for one app
just build-gem fizzy rack      # build single gem (debugging)
just matrix fizzy              # build across all ruby versions
just matrix fizzy ruby_4_0    # single ruby version
just import fizzy path/to/Gemfile.lock
just fetch                     # fetch all gem sources
just generate                  # regenerate nix/ from cache
just lint                      # run all 10 lints
just test fizzy                # run app test suite
```

### Scripts

| Script | Purpose |
|--------|---------|
| `bin/import` | Import a project: `Gemfile.lock` → gemset + nix config + git derivations |
| `bin/fetch` | Fetch gems in parallel: `imports/*.gemset` → `cache/` |
| `bin/fetch-gem` | Fetch a single gem (called by `bin/fetch`) |
| `bin/generate` | Generate derivations + selectors + catalogue from `cache/meta/` |
| `bin/generate-gemset` | Generate `nix/app/<project>.nix` from `Gemfile.lock` |
| `bin/test-bundle` | Smoke test: build bundle-path, verify `bundler/setup` loads |

## Lint suite

10 automated checks:

```bash
$ just lint
nix-eval:                     5231 checked, 0 errors
nixfmt:                       5236 files, all formatted
statix:                       0 warnings
dep-completeness:             OK (186 specs in lockfile)
source-clean:                 OK (no leaked .so files)
require-paths-vs-gem-metadata: OK (3782 checked)
gemspec-deps:                 OK (172 gemspecs checked)
require-paths:                OK (172 specs checked)
native-extensions:            1 warning out of 53
loadable:                     7 OK, 0 failed
── 10 passed, 0 failed ──
```

## Tested projects

| Project | Type | Gems | Ruby | Test result |
|---------|------|-----:|------|-------------|
| **Fizzy** | Rails 8.2 | 161 | 3.1–4.0 | ✅ 1,026 tests, 4,011 assertions, 0 errors |
| **Liquid** | Library | 44 | 3.4 | ✅ 973 tests, 0 errors |
| **Chatwoot** | Rails 7.1 | 364 | 3.4 | ✅ 757 examples, 0 failures |

Import-ready (gemsets generated, gems fetched): Discourse (296), Mastodon (350), Forem (381), Redmine (154), Solidus (200), Spree (222), Rails (217).

## Design decisions

- **One derivation per gem** — individually cacheable, parallel builds, content-addressed
- **Pure data gemsets** — `nix/app/*.nix` is just a list, no logic
- **Lazy evaluation everywhere** — only selected versions get imported
- **Overlay-based customization** — generated code never needs hand-editing
- **System libraries always** — vendored copies are stripped; overlays point to nixpkgs
- **`builtins.fetchGit` for git gems** — no pre-cloning, nix fetches at eval time
- **Platform-native mimicry** — source-compiled gems look like prebuilt platform gems to bundler
- **Parameterized Ruby** — `ruby` flows through every derivation; change once, rebuild
