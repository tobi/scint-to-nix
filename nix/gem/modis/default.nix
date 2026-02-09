#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# modis
#
# Available versions:
#   4.0.1
#
# Usage:
#   modis { version = "4.0.1"; }
#   modis { }  # latest (4.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.1",
  git ? { },
}:
let
  versions = {
    "4.0.1" = import ./4.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "modis: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "modis: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
