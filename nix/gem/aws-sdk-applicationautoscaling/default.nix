#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-applicationautoscaling
#
# Available versions:
#   1.116.0
#   1.117.0
#   1.118.0
#
# Usage:
#   aws-sdk-applicationautoscaling { version = "1.118.0"; }
#   aws-sdk-applicationautoscaling { }  # latest (1.118.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.118.0",
  git ? { },
}:
let
  versions = {
    "1.116.0" = import ./1.116.0 { inherit lib stdenv ruby; };
    "1.117.0" = import ./1.117.0 { inherit lib stdenv ruby; };
    "1.118.0" = import ./1.118.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-applicationautoscaling: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-applicationautoscaling: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
