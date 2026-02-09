#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-lambda
#
# Available versions:
#   1.173.0
#   1.174.0
#   1.175.0
#
# Usage:
#   aws-sdk-lambda { version = "1.175.0"; }
#   aws-sdk-lambda { }  # latest (1.175.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.175.0",
  git ? { },
}:
let
  versions = {
    "1.173.0" = import ./1.173.0 { inherit lib stdenv ruby; };
    "1.174.0" = import ./1.174.0 { inherit lib stdenv ruby; };
    "1.175.0" = import ./1.175.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-lambda: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-lambda: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
