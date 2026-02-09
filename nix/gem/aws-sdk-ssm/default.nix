#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ssm
#
# Available versions:
#   1.208.0
#   1.209.0
#   1.210.0
#
# Usage:
#   aws-sdk-ssm { version = "1.210.0"; }
#   aws-sdk-ssm { }  # latest (1.210.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.210.0",
  git ? { },
}:
let
  versions = {
    "1.208.0" = import ./1.208.0 { inherit lib stdenv ruby; };
    "1.209.0" = import ./1.209.0 { inherit lib stdenv ruby; };
    "1.210.0" = import ./1.210.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-ssm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-ssm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
