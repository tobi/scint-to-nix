#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iot1clickprojects
#
# Available versions:
#   1.63.0
#   1.64.0
#   1.65.0
#
# Usage:
#   aws-sdk-iot1clickprojects { version = "1.65.0"; }
#   aws-sdk-iot1clickprojects { }  # latest (1.65.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.65.0",
  git ? { },
}:
let
  versions = {
    "1.63.0" = import ./1.63.0 { inherit lib stdenv ruby; };
    "1.64.0" = import ./1.64.0 { inherit lib stdenv ruby; };
    "1.65.0" = import ./1.65.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iot1clickprojects: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-iot1clickprojects: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
