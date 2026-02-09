#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tilt
#
# Available versions:
#   2.3.0
#   2.6.0
#   2.6.1
#   2.7.0
#
# Usage:
#   tilt { version = "2.7.0"; }
#   tilt { }  # latest (2.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.0",
  git ? { },
}:
let
  versions = {
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.6.0" = import ./2.6.0 { inherit lib stdenv ruby; };
    "2.6.1" = import ./2.6.1 { inherit lib stdenv ruby; };
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tilt: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tilt: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
