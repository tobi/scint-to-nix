#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-apigatewaymanagementapi
#
# Available versions:
#   1.70.0
#   1.71.0
#   1.72.0
#
# Usage:
#   aws-sdk-apigatewaymanagementapi { version = "1.72.0"; }
#   aws-sdk-apigatewaymanagementapi { }  # latest (1.72.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.72.0",
  git ? { },
}:
let
  versions = {
    "1.70.0" = import ./1.70.0 { inherit lib stdenv ruby; };
    "1.71.0" = import ./1.71.0 { inherit lib stdenv ruby; };
    "1.72.0" = import ./1.72.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-apigatewaymanagementapi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-apigatewaymanagementapi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
