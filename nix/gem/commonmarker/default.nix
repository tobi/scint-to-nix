#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# commonmarker
#
# Available versions:
#   0.23.10
#   2.6.1
#   2.6.2
#   2.6.3
#
# Usage:
#   commonmarker { version = "2.6.3"; }
#   commonmarker { }  # latest (2.6.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.3",
  git ? { },
}:
let
  versions = {
    "0.23.10" = import ./0.23.10 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "2.6.1" = import ./2.6.1 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "2.6.2" = import ./2.6.2 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "2.6.3" = import ./2.6.3 {
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
    or (throw "commonmarker: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "commonmarker: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
