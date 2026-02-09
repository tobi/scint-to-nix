#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-codepipeline
#
# Available versions:
#   1.110.0
#   1.111.0
#   1.112.0
#
# Usage:
#   aws-sdk-codepipeline { version = "1.112.0"; }
#   aws-sdk-codepipeline { }  # latest (1.112.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.112.0",
  git ? { },
}:
let
  versions = {
    "1.110.0" = import ./1.110.0 { inherit lib stdenv ruby; };
    "1.111.0" = import ./1.111.0 { inherit lib stdenv ruby; };
    "1.112.0" = import ./1.112.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-codepipeline: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-codepipeline: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
