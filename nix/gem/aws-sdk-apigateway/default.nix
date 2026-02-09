#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-apigateway
#
# Available versions:
#   1.129.0
#   1.130.0
#   1.131.0
#
# Usage:
#   aws-sdk-apigateway { version = "1.131.0"; }
#   aws-sdk-apigateway { }  # latest (1.131.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.131.0",
  git ? { },
}:
let
  versions = {
    "1.129.0" = import ./1.129.0 { inherit lib stdenv ruby; };
    "1.130.0" = import ./1.130.0 { inherit lib stdenv ruby; };
    "1.131.0" = import ./1.131.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-apigateway: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-apigateway: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
