#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# babel-source
#
# Available versions:
#   5.8.33
#   5.8.34
#   5.8.35
#
# Usage:
#   babel-source { version = "5.8.35"; }
#   babel-source { }  # latest (5.8.35)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.8.35",
  git ? { },
}:
let
  versions = {
    "5.8.33" = import ./5.8.33 { inherit lib stdenv ruby; };
    "5.8.34" = import ./5.8.34 { inherit lib stdenv ruby; };
    "5.8.35" = import ./5.8.35 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "babel-source: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "babel-source: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
