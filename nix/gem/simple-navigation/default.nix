#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simple-navigation
#
# Available versions:
#   4.4.1
#
# Usage:
#   simple-navigation { version = "4.4.1"; }
#   simple-navigation { }  # latest (4.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.1",
  git ? { },
}:
let
  versions = {
    "4.4.1" = import ./4.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simple-navigation: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "simple-navigation: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
