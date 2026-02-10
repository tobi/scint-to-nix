# onix

Nix-packaged Ruby gems. Takes a `Gemfile.lock`, builds every gem once, caches forever.

```
$ onix import ~/src/rails     # read Gemfile.lock, generate nix gem list
$ onix import ~/src/shopify  # import as many projects as you want
$ onix fetch                 # download .gem files, unpack sources
$ onix generate              # emit one nix derivation per gem
$ onix build                 # build everything, cache forever
```

## Install

```bash
gem install specific_install
gem specific_install https://github.com/tobi/onix
```

Requires Ruby ≥ 3.1 and Nix.

## Workflow

### 1. Initialize a project

```bash
mkdir my-gems && cd my-gems
onix init
```

Creates the directory structure: `cache/`, `nix/`, `overlays/`, `gemsets/`.

### 2. Import a Gemfile.lock

```bash
onix import ~/src/myapp              # reads myapp/Gemfile.lock
onix import --name blog Gemfile.lock  # explicit name
```

The gemset file is a copy of your `Gemfile.lock` — Bundler's own parser reads it back. Also generates `nix/app/<name>.nix` (the gem list for Nix).

### 3. Fetch sources

```bash
onix fetch        # default: 20 parallel jobs
onix fetch -j 8   # fewer jobs
```

Downloads `.gem` files, unpacks sources, extracts metadata, clones git repos. Everything goes into `cache/` — no network access needed after this step.

### 4. Generate derivations

```bash
onix generate
```

Scans cached sources and metadata, auto-detects native dependencies from `extconf.rb`, and writes:
- `nix/gem/<name>/<version>/default.nix` — one derivation per gem
- `nix/gem/<name>/default.nix` — version selector
- `nix/modules/gem.nix` — catalogue of all gems

### 5. Build

```bash
onix build                    # build every gem in the pool
onix build myapp              # build all gems for one app
onix build myapp nokogiri     # build a single gem from an app
onix build --gem nokogiri     # build by name (latest version)
```

Shows live progress during builds. On failure, prints the gem name, whether to create or edit an overlay, and the exact `nix log` command:

```
  ✗ sqlite3  →  create overlays/sqlite3.nix
    nix log /nix/store/...-sqlite3-2.8.0.drv
```

### 6. Check

```bash
onix check                        # all checks
onix check symlinks dep-completeness  # specific ones
```

Checks: `symlinks` · `nix-eval` · `source-clean` · `secrets` · `dep-completeness` · `require-paths-vs-metadata`. All run in parallel.

## Using built gems

`resolve` is the Nix-side API. Pass it `pkgs`, `ruby`, and a config — it returns an attrset with:

| Key | Type | Description |
|-----|------|-------------|
| `<gem-name>` | derivation | Individual gem outputs (one per gem) |
| `bundlePath` | derivation | All gems merged into a single `BUNDLE_PATH` via `buildEnv` |
| `devShell` | function | `mkShell` wrapper that sets `BUNDLE_PATH`, `BUNDLE_GEMFILE`, and includes `ruby` |

### devShell (recommended)

The simplest way to use onix. Handles all Bundler plumbing automatically:

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

`devShell` accepts the same arguments as `mkShell`. It prepends `ruby` to `buildInputs` and prepends the `BUNDLE_PATH`/`BUNDLE_GEMFILE` exports to your `shellHook`.

### bundlePath

If you need more control (CI scripts, Docker images, custom derivations), use `bundlePath` directly:

```nix
gems.bundlePath        # → /nix/store/...-onix-bundle
                       # contains ruby/3.4.0/gems/*, specifications/*, extensions/*,
                       # and bundler/gems/* for git sources
```

### Config namespace

The config namespace:

```nix
config = {
  onix.apps.rails.enable = true;         # enable an app preset (all locked gems)
  onix.ruby.rack = { enable = true; version = "3.2.4"; };  # pin a specific gem
};
```

### Git-sourced gems

Git gems from `Gemfile.lock` are handled automatically. The import preserves the full lockfile, `fetch` clones the repo, and `generate` creates a derivation at `nix/gem/<repo>/git-<shortrev>/`.

## Overlays

Most gems build automatically — `generate` scans `extconf.rb` and inlines detected `pkg_config`, `find_library`, and `have_header` calls as nixpkgs deps. It also detects Rust gems using `rb_sys`.

When auto-detection isn't enough, write an overlay in `overlays/<gem>.nix`. **Manual overlays always win** over auto-detection.

### System library deps

```nix
# overlays/pg.nix
{ pkgs, ruby }: with pkgs; [ libpq pkg-config ]
```

A list is shorthand for "add these to `nativeBuildInputs`, use default build phase."

### System library flags

Force gems to use system libraries instead of vendored copies:

```nix
# overlays/sqlite3.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

### Build-time gem dependencies

Some gems need other gems during `extconf.rb`. Use `buildGems` — each entry is a derivation (built via `pkgs.callPackage`). The framework constructs `GEM_PATH` automatically from each derivation's `bundle_path`:

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

The default build phase finds every `ext/**/extconf.rb`, runs `ruby extconf.rb $extconfFlags && make`, and copies the `.so` into `lib/`.

### Skip a gem

```nix
# overlays/therubyracer.nix — abandoned
{ pkgs, ruby }: { buildPhase = "true"; }
```

## Examples

The `examples/` directory contains a working project with 10 imported Ruby apps (3,786 gem versions, 35 overlays):

```bash
cd examples
just generate       # regenerate all derivations
just build fizzy    # build one app
just test fizzy     # run app tests in nix devshell
just test-all       # run all 10 app test suites
just check          # run lint checks
```

### Tested apps

| App | Gems | Test |
|-----|------|------|
| fizzy | 161 | minitest suite |
| liquid | 44 | 5,106 tests across 6 modes |
| chatwoot | 364 | Rails boot |
| discourse | 296 | Rails runner |
| forem | 381 | Rails boot |
| mastodon | 350 | Rails boot |
| rails | 217 | require + boot |
| redmine | 154 | Rails boot |
| solidus | 200 | Rails boot |
| spree | 222 | require spree/core |

## Directory structure

```
my-gems/
├── gemsets/          # Gemfile.lock copies (one per project)
├── overlays/         # Hand-written build overrides
├── cache/
│   ├── sources/      # Unpacked gem source trees
│   ├── meta/         # Gem metadata (JSON)
│   ├── gems/         # Downloaded .gem files
│   └── git-clones/   # Bare git clones
└── nix/              # Generated — never edit by hand
    ├── gem/          # Per-gem derivations + version selectors
    ├── app/          # Per-project gem lists
    └── modules/      # Catalogue, resolver, app registry
```

## Design

- **Everything local.** `fetch` downloads all sources ahead of time. Nix builds use `builtins.path` only — no network, no `fetchGit`, no `fetchurl`.
- **System libraries only.** Native gems link against nixpkgs. Vendored copies are stripped.
- **Gemfile.lock is the source of truth.** Gemset files are unmodified copies, parsed by Bundler's `LockfileParser`.
- **One derivation per gem.** Individually cacheable, parallel builds, content-addressed store paths.
- **Auto-detect where possible, overlay where not.** `extconf.rb` analysis inlines common deps. Overlays handle the rest.
- **Manual overlays always win** over auto-detection.
- **Parameterized Ruby.** `ruby` flows through every derivation — one argument changes the whole build.
- **Zero external deps.** The CLI needs only Ruby (bundler ships with it since 2.6).
