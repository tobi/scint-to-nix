#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-dynamodb
#
# Available versions:
#   1.160.0
#   1.161.0
#   1.162.0
#
# Usage:
#   aws-sdk-dynamodb { version = "1.162.0"; }
#   aws-sdk-dynamodb { }  # latest (1.162.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.162.0",
  git ? { },
}:
let
  versions = {
    "1.160.0" = import ./1.160.0 { inherit lib stdenv ruby; };
    "1.161.0" = import ./1.161.0 { inherit lib stdenv ruby; };
    "1.162.0" = import ./1.162.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-dynamodb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-dynamodb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
