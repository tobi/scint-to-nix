#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloudwatchlogs
#
# Available versions:
#   1.136.0
#   1.137.0
#   1.138.0
#
# Usage:
#   aws-sdk-cloudwatchlogs { version = "1.138.0"; }
#   aws-sdk-cloudwatchlogs { }  # latest (1.138.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.138.0",
  git ? { },
}:
let
  versions = {
    "1.136.0" = import ./1.136.0 { inherit lib stdenv ruby; };
    "1.137.0" = import ./1.137.0 { inherit lib stdenv ruby; };
    "1.138.0" = import ./1.138.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloudwatchlogs: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-cloudwatchlogs: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
