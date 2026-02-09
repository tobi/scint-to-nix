#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-polly
#
# Available versions:
#   1.117.0
#   1.118.0
#   1.119.0
#
# Usage:
#   aws-sdk-polly { version = "1.119.0"; }
#   aws-sdk-polly { }  # latest (1.119.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.119.0",
  git ? { },
}:
let
  versions = {
    "1.117.0" = import ./1.117.0 { inherit lib stdenv ruby; };
    "1.118.0" = import ./1.118.0 { inherit lib stdenv ruby; };
    "1.119.0" = import ./1.119.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-polly: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-polly: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
