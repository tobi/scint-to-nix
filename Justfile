# scint-to-nix — Justfile
#
# Usage:
#   just build fizzy            # build all gems + bundle-path
#   just test fizzy              # run app test suite
#   just lint fizzy              # run lint suite
#   just generate                # regenerate nix/ from cache
#   just fetch                   # populate cache from .gems manifests

set shell := ["bash", "-euo", "pipefail", "-c"]

ruby := "ruby_3_4"

# ── Build ──────────────────────────────────────────────────────────

# Build all gems for an app + assemble the bundle-path
build app:
    #!/usr/bin/env bash
    echo "Building all gems for {{app}}..."
    out=$(nix-build --no-out-link --keep-going -E '
        let pkgs = import <nixpkgs> {};
            ruby = pkgs.{{ruby}};
            gems = import ./nix/app/{{app}}.nix { inherit pkgs ruby; };
        in pkgs.buildEnv {
            name = "{{app}}-bundle-path";
            paths = builtins.attrValues gems;
        }
    ')
    n=$(nix-build --no-out-link -E '
        let pkgs = import <nixpkgs> {};
            ruby = pkgs.{{ruby}};
            gems = import ./nix/app/{{app}}.nix { inherit pkgs ruby; };
        in builtins.attrValues gems
    ' 2>/dev/null | wc -l)
    echo "$n gems → $out"

# Build individual gems (for debugging failures)
[group('build')]
build-gem app gem:
    nix-build --no-out-link -E 'let pkgs = import <nixpkgs> {}; ruby = pkgs.{{ruby}}; gems = import ./nix/app/{{app}}.nix { inherit pkgs ruby; }; in gems."{{gem}}"'

# ── Fetch & Generate ──────────────────────────────────────────────

# Fetch all gem sources into cache/
[group('generate')]
fetch:
    bin/fetch gems/

# Recreate source symlinks (after fresh clone)
[group('generate')]
link:
    #!/usr/bin/env bash
    n=0
    for d in nix/gem/*/*/; do
        [[ -d "$d" ]] || continue
        [[ "$(basename "$d")" == git-* ]] && continue
        name=$(basename "$(dirname "$d")")
        version=$(basename "$d")
        target="cache/sources/${name}-${version}"
        link="${d}source"
        if [[ -d "$target" && ! -e "$link" ]]; then
            ln -sf "$(cd "$target" && pwd)" "$link"
            n=$((n + 1))
        fi
    done
    echo "Linked $n source directories."

# Regenerate all gem derivations + selectors from cache
[group('generate')]
generate:
    bin/generate

# Generate an app gemset from a Gemfile.lock
[group('generate')]
generate-gemset app lockfile:
    bin/generate-gemset {{app}} {{lockfile}}

# Full pipeline: generate + gemset
[group('generate')]
regenerate app lockfile: generate (generate-gemset app lockfile)

# ── Test & Lint ────────────────────────────────────────────────────

# Run the app's test suite via its devshell
[group('test')]
test app *args:
    #!/usr/bin/env bash
    cd ../{{app}}
    rm -rf tmp/cache/bootsnap 2>/dev/null || true
    nix-shell ../scint-to-nix/tests/{{app}}/devshell.nix \
        --run "RAILS_ENV=test bundle exec rails test {{args}}"

# Run lint suite
[group('test')]
lint app="fizzy":
    tests/lint/run-all {{app}}

# Verify all generated nix files pass nixfmt
[group('test')]
fmt-check:
    find nix/ -name '*.nix' | xargs nixfmt --check
