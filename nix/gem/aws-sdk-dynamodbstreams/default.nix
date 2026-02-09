#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-dynamodbstreams
#
# Available versions:
#   1.87.0
#   1.88.0
#   1.89.0
#
# Usage:
#   aws-sdk-dynamodbstreams { version = "1.89.0"; }
#   aws-sdk-dynamodbstreams { }  # latest (1.89.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.89.0",
  git ? { },
}:
let
  versions = {
    "1.87.0" = import ./1.87.0 { inherit lib stdenv ruby; };
    "1.88.0" = import ./1.88.0 { inherit lib stdenv ruby; };
    "1.89.0" = import ./1.89.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-dynamodbstreams: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-dynamodbstreams: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
