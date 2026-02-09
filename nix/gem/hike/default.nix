#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hike
#
# Available versions:
#   2.1.1
#   2.1.2
#   2.1.3
#
# Usage:
#   hike { version = "2.1.3"; }
#   hike { }  # latest (2.1.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.3",
  git ? { },
}:
let
  versions = {
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "2.1.3" = import ./2.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hike: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "hike: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
