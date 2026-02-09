#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ice_cube
#
# Available versions:
#   0.16.3
#   0.16.4
#   0.17.0
#
# Usage:
#   ice_cube { version = "0.17.0"; }
#   ice_cube { }  # latest (0.17.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.17.0",
  git ? { },
}:
let
  versions = {
    "0.16.3" = import ./0.16.3 { inherit lib stdenv ruby; };
    "0.16.4" = import ./0.16.4 { inherit lib stdenv ruby; };
    "0.17.0" = import ./0.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ice_cube: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ice_cube: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
