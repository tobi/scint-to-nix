#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fastlane
#
# Available versions:
#   2.231.0
#   2.231.1
#   2.232.0
#
# Usage:
#   fastlane { version = "2.232.0"; }
#   fastlane { }  # latest (2.232.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.232.0",
  git ? { },
}:
let
  versions = {
    "2.231.0" = import ./2.231.0 { inherit lib stdenv ruby; };
    "2.231.1" = import ./2.231.1 { inherit lib stdenv ruby; };
    "2.232.0" = import ./2.232.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fastlane: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fastlane: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
