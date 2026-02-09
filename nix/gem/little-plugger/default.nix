#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# little-plugger
#
# Available versions:
#   1.1.2
#   1.1.4
#
# Usage:
#   little-plugger { version = "1.1.4"; }
#   little-plugger { }  # latest (1.1.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.4",
  git ? { },
}:
let
  versions = {
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.1.4" = import ./1.1.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "little-plugger: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "little-plugger: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
