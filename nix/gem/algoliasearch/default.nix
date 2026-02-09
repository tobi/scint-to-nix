#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algoliasearch
#
# Available versions:
#   1.27.3
#   1.27.4
#   1.27.5
#
# Usage:
#   algoliasearch { version = "1.27.5"; }
#   algoliasearch { }  # latest (1.27.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.27.5",
  git ? { },
}:
let
  versions = {
    "1.27.3" = import ./1.27.3 { inherit lib stdenv ruby; };
    "1.27.4" = import ./1.27.4 { inherit lib stdenv ruby; };
    "1.27.5" = import ./1.27.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "algoliasearch: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "algoliasearch: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
