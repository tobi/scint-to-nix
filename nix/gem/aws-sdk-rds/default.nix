#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-rds
#
# Available versions:
#   1.304.0
#   1.305.0
#   1.306.0
#
# Usage:
#   aws-sdk-rds { version = "1.306.0"; }
#   aws-sdk-rds { }  # latest (1.306.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.306.0",
  git ? { },
}:
let
  versions = {
    "1.304.0" = import ./1.304.0 { inherit lib stdenv ruby; };
    "1.305.0" = import ./1.305.0 { inherit lib stdenv ruby; };
    "1.306.0" = import ./1.306.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-rds: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-rds: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
