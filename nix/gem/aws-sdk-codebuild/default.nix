#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-codebuild
#
# Available versions:
#   1.168.0
#   1.169.0
#   1.170.0
#
# Usage:
#   aws-sdk-codebuild { version = "1.170.0"; }
#   aws-sdk-codebuild { }  # latest (1.170.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.170.0",
  git ? { },
}:
let
  versions = {
    "1.168.0" = import ./1.168.0 { inherit lib stdenv ruby; };
    "1.169.0" = import ./1.169.0 { inherit lib stdenv ruby; };
    "1.170.0" = import ./1.170.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-codebuild: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-codebuild: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
