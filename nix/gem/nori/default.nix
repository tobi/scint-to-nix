#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nori
#
# Available versions:
#   2.6.0
#   2.7.0
#   2.7.1
#
# Usage:
#   nori { version = "2.7.1"; }
#   nori { }  # latest (2.7.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.1",
  git ? { },
}:
let
  versions = {
    "2.6.0" = import ./2.6.0 { inherit lib stdenv ruby; };
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
    "2.7.1" = import ./2.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "nori: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "nori: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
