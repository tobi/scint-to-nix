#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iotjobsdataplane
#
# Available versions:
#   1.77.0
#   1.78.0
#   1.79.0
#
# Usage:
#   aws-sdk-iotjobsdataplane { version = "1.79.0"; }
#   aws-sdk-iotjobsdataplane { }  # latest (1.79.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.79.0",
  git ? { },
}:
let
  versions = {
    "1.77.0" = import ./1.77.0 { inherit lib stdenv ruby; };
    "1.78.0" = import ./1.78.0 { inherit lib stdenv ruby; };
    "1.79.0" = import ./1.79.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iotjobsdataplane: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-iotjobsdataplane: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
