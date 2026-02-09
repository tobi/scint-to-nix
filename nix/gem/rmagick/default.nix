#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rmagick
#
# Available versions:
#   6.1.3
#   6.1.4
#   6.1.5
#
# Usage:
#   rmagick { version = "6.1.5"; }
#   rmagick { }  # latest (6.1.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.1.5",
  git ? { },
}:
let
  versions = {
    "6.1.3" = import ./6.1.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "6.1.4" = import ./6.1.4 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "6.1.5" = import ./6.1.5 {
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
    or (throw "rmagick: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rmagick: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
