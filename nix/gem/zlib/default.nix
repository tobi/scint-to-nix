#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zlib
#
# Available versions:
#   2.1.1
#
# Usage:
#   zlib { version = "2.1.1"; }
#   zlib { }  # latest (2.1.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.1",
  git ? { },
}:
let
  versions = {
    "2.1.1" = import ./2.1.1 {
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
    or (throw "zlib: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "zlib: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
