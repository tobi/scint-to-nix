#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iot1clickdevicesservice
#
# Available versions:
#   1.61.0
#   1.62.0
#   1.63.0
#
# Usage:
#   aws-sdk-iot1clickdevicesservice { version = "1.63.0"; }
#   aws-sdk-iot1clickdevicesservice { }  # latest (1.63.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.63.0",
  git ? { },
}:
let
  versions = {
    "1.61.0" = import ./1.61.0 { inherit lib stdenv ruby; };
    "1.62.0" = import ./1.62.0 { inherit lib stdenv ruby; };
    "1.63.0" = import ./1.63.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iot1clickdevicesservice: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-iot1clickdevicesservice: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
