#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gems
#
# Available versions:
#   1.1.1
#   1.2.0
#   1.3.0
#
# Usage:
#   gems { version = "1.3.0"; }
#   gems { }  # latest (1.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.0",
  git ? { },
}:
let
  versions = {
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gems: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gems: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
