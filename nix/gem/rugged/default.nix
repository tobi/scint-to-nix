#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rugged
#
# Available versions:
#   1.7.1
#   1.7.2
#   1.9.0
#
# Usage:
#   rugged { version = "1.9.0"; }
#   rugged { }  # latest (1.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.0",
  git ? { },
}:
let
  versions = {
    "1.7.1" = import ./1.7.1 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.7.2" = import ./1.7.2 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.9.0" = import ./1.9.0 {
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
    or (throw "rugged: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rugged: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
