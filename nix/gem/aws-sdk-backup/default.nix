#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-backup
#
# Available versions:
#   1.105.0
#   1.106.0
#   1.107.0
#
# Usage:
#   aws-sdk-backup { version = "1.107.0"; }
#   aws-sdk-backup { }  # latest (1.107.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.107.0",
  git ? { },
}:
let
  versions = {
    "1.105.0" = import ./1.105.0 { inherit lib stdenv ruby; };
    "1.106.0" = import ./1.106.0 { inherit lib stdenv ruby; };
    "1.107.0" = import ./1.107.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-backup: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-backup: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
