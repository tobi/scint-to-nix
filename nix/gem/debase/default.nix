#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# debase
#
# Available versions:
#   0.2.7
#   0.2.8
#   0.2.9
#
# Usage:
#   debase { version = "0.2.9"; }
#   debase { }  # latest (0.2.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.9",
  git ? { },
}:
let
  versions = {
    "0.2.7" = import ./0.2.7 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "0.2.8" = import ./0.2.8 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "0.2.9" = import ./0.2.9 {
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
    or (throw "debase: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "debase: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
