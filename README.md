# gemset2nix

A Nix package set for Ruby gems. 1,413 gems, 3,786 versions, all building from source with correct native dependencies — ready to compose into any Ruby project.

```nix
let
  pkgs = import <nixpkgs> {};
  ruby = pkgs.ruby_3_4;
  gem = name: args: import (./nix/gem + "/${name}") ({ inherit (pkgs) lib stdenv; inherit ruby pkgs; } // args);
in
{
  rack    = gem "rack"    { version = "3.2.4"; };
  pg      = gem "pg"      { version = "1.5.9"; };
  nokogiri = gem "nokogiri" { version = "1.19.0"; };  # links system libxml2
  puma    = gem "puma"    { version = "6.6.0"; };      # compiles C extension
}
```

Every gem is a standalone Nix derivation. Pure-ruby gems just copy files. Native gems compile from source in the Nix sandbox, linked against system libraries from nixpkgs — never vendored copies.

## The gem pool

```
nix/gem/
├── rack/
│   ├── default.nix            # selector — dispatches by version or git rev
│   ├── 3.2.3/default.nix     # standalone derivation
│   └── 3.2.4/default.nix
├── nokogiri/
│   ├── default.nix
│   ├── 1.18.9/default.nix
│   ├── 1.18.10/default.nix
│   └── 1.19.0/default.nix
├── rails/
│   ├── default.nix
│   ├── 8.1.2/default.nix
│   └── git-60d92e4e7dfe/     # pinned git checkout
└── ...                        # 1,413 gems
```

Each gem derivation takes `{ lib, stdenv, ruby }` (plus `pkgs` for native gems with overlays). The output is a fragment of a `BUNDLE_PATH`:

```
$out/ruby/3.4.0/
├── gems/rack-3.2.4/
├── specifications/rack-3.2.4.gemspec
└── extensions/x86_64-linux/3.4.0/nokogiri-1.19.0/nokogiri.so
```

Merge any set of gems with `buildEnv` and you get a complete `BUNDLE_PATH` that `require "bundler/setup"` accepts without modification.

## Native gem overlays

32 overlays declare system library dependencies for native gems. These are the only hand-maintained files — everything else is generated.

```nix
# overlays/sqlite3.nix
{ pkgs, ruby }:
{
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

```nix
# overlays/nokogiri.nix
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

```nix
# overlays/tiktoken_ruby.nix — Rust extension
{ pkgs, ruby }:
let
  rb_sys = pkgs.callPackage ../nix/gem/rb_sys/0.9.113 { inherit ruby; };
  cargoDeps = pkgs.fetchCargoVendor { ... };
in {
  deps = with pkgs; [ rustPlatform.rust.cargo rustPlatform.rust.rustc pkg-config llvmPackages.libclang ];
  beforeBuild = ''
    export GEM_PATH=${rb_sys}/${rb_sys.prefix}
    export LIBCLANG_PATH="${pkgs.llvmPackages.libclang.lib}/lib"
    mkdir -p .cargo
    sed "s|@vendor@|${cargoDeps}|" ${cargoDeps}/.cargo/config.toml > .cargo/config.toml
  '';
}
```

### Overlay contract

| Field | Type | Effect |
|-------|------|--------|
| `deps` | `[ derivation ]` | Added to `nativeBuildInputs` |
| `extconfFlags` | `string` | Passed to `ruby extconf.rb $extconfFlags` |
| `beforeBuild` | `string` | Runs before `extconf.rb && make` |
| `afterBuild` | `string` | Runs after `make` |
| `postInstall` | `string` | Runs after install (`$dest` = output prefix) |
| `buildPhase` | `string` | **Replaces** the default build entirely |

A list return is shorthand for deps-only: `{ pkgs, ruby }: [ pkgs.openssl ]`.

**Rule: always link against system libraries from nixpkgs.** Never vendored/bundled copies.

### Current overlays

`charlock_holmes` · `commonmarker` · `debase` · `extralite-bundle` · `ffi` · `ffi-yajl` · `field_test` · `google-protobuf` · `gpgme` · `hiredis` · `hiredis-client` · `idn-ruby` · `libv8` · `libv8-node` · `libxml-ruby` · `mini_racer` · `mittens` · `mysql2` · `nokogiri` · `openssl` · `pg` · `psych` · `puma` · `rmagick` · `rpam2` · `rugged` · `sqlite3` · `therubyracer` · `tiktoken_ruby` · `tokenizers` · `trilogy` · `zlib`

## Using it with a project

### From a Gemfile.lock

```bash
# Import generates a gemset config from your lockfile
bin/import myapp ~/src/myapp/Gemfile.lock

# Result: nix/app/myapp.nix — a plain list of { name; version; }
```

### Devshell

```nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  resolve = import ./nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = import ./nix/app/myapp.nix; };
  bundlePath = pkgs.buildEnv {
    name = "myapp-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  buildInputs = [ ruby ];
  shellHook = ''
    export BUNDLE_PATH="${bundlePath}"
    export BUNDLE_GEMFILE="$PWD/Gemfile"
  '';
}
```

### Ruby version matrix

```bash
just matrix myapp              # build on all rubies (3.1, 3.2, 3.3, 3.4, 4.0)
just matrix myapp ruby_4_0    # single version
```

```bash
nix-build nix/matrix.nix -A ruby_3_4.myapp
```

## Growing the pool

### Add gems from a project

```bash
bin/import myapp ~/src/myapp/Gemfile.lock   # writes imports/myapp.gemset
bin/fetch                                    # fetches new gems into cache/
bin/generate                                 # regenerates nix/gem/ tree
bin/generate-gemset myapp ~/src/myapp/Gemfile.lock  # writes nix/app/myapp.nix
```

### Add popular gems in bulk

```bash
bin/fetch-top-gems          # top 1000 rubygems, 3 versions each
bin/generate                # regenerates everything
```

### Add an overlay for a new native gem

Create `overlays/<gem>.nix`:

```nix
{ pkgs, ruby }:
{
  deps = with pkgs; [ libfoo pkg-config ];
  extconfFlags = "--use-system-libraries";
}
```

Then `bin/generate` picks it up automatically — the derivation template detects the overlay and wires in the hooks.

## Building

```bash
just build                  # build all 3,786 gem versions
just build myapp            # build gems for one project
just build-gem myapp rack   # build a single gem (debugging)
just matrix                 # full ruby version matrix
just lint                   # 10 automated checks
```

## Lint suite

```
nix-eval:                      5,231 files, 0 errors
nixfmt:                        5,236 files, all formatted
statix:                        0 warnings
dep-completeness:              OK
source-clean:                  no leaked .so files
require-paths-vs-gem-metadata: 3,782 checked
gemspec-deps:                  172 gemspecs checked
require-paths:                 172 specs checked
native-extensions:             53 native gems verified
loadable:                      7 key gems load successfully
```

## Design

- **One derivation per gem** — individually cacheable, parallel builds, content-addressed store paths
- **Lazy evaluation** — only gems you select get built; the rest of the pool is never touched
- **System libraries always** — vendored copies stripped; overlays point to nixpkgs
- **`builtins.fetchGit` for git gems** — nix fetches at eval time, pinned to exact commit
- **Platform-native mimicry** — source-compiled gems look like prebuilt platform gems to bundler
- **Parameterized Ruby** — `ruby` flows through every derivation; one argument changes everything
- **Zero dependencies** — the tool itself needs only Ruby (bundler ships with it since 2.6)
- **Generated, not templated** — the entire `nix/` tree is regenerated from cache; overlays are the only manual layer
