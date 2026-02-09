#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloudfront
#
# Available versions:
#   1.139.0
#   1.140.0
#   1.141.0
#
# Usage:
#   aws-sdk-cloudfront { version = "1.141.0"; }
#   aws-sdk-cloudfront { }  # latest (1.141.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.141.0",
  git ? { },
}:
let
  versions = {
    "1.139.0" = import ./1.139.0 { inherit lib stdenv ruby; };
    "1.140.0" = import ./1.140.0 { inherit lib stdenv ruby; };
    "1.141.0" = import ./1.141.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloudfront: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-cloudfront: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
