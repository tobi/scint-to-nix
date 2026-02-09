#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# geocoder
#
# Available versions:
#   1.8.1
#   1.8.4
#   1.8.5
#   1.8.6
#
# Usage:
#   geocoder { version = "1.8.6"; }
#   geocoder { }  # latest (1.8.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.6",
  git ? { },
}:
let
  versions = {
    "1.8.1" = import ./1.8.1 { inherit lib stdenv ruby; };
    "1.8.4" = import ./1.8.4 { inherit lib stdenv ruby; };
    "1.8.5" = import ./1.8.5 { inherit lib stdenv ruby; };
    "1.8.6" = import ./1.8.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "geocoder: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "geocoder: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
