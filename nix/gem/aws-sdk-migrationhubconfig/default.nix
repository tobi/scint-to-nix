#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-migrationhubconfig
#
# Available versions:
#   1.62.0
#   1.63.0
#   1.64.0
#
# Usage:
#   aws-sdk-migrationhubconfig { version = "1.64.0"; }
#   aws-sdk-migrationhubconfig { }  # latest (1.64.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.64.0",
  git ? { },
}:
let
  versions = {
    "1.62.0" = import ./1.62.0 { inherit lib stdenv ruby; };
    "1.63.0" = import ./1.63.0 { inherit lib stdenv ruby; };
    "1.64.0" = import ./1.64.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-migrationhubconfig: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-migrationhubconfig: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
