#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffi
#
# Available versions:
#   1.16.3
#   1.17.1
#   1.17.2
#   1.17.3
#
# Usage:
#   ffi { version = "1.17.3"; }
#   ffi { }  # latest (1.17.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.17.3",
  git ? { },
}:
let
  versions = {
    "1.16.3" = import ./1.16.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.17.1" = import ./1.17.1 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.17.2" = import ./1.17.2 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.17.3" = import ./1.17.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ffi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ffi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
