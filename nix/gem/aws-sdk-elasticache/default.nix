#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-elasticache
#
# Available versions:
#   1.137.0
#   1.138.0
#   1.139.0
#
# Usage:
#   aws-sdk-elasticache { version = "1.139.0"; }
#   aws-sdk-elasticache { }  # latest (1.139.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.139.0",
  git ? { },
}:
let
  versions = {
    "1.137.0" = import ./1.137.0 { inherit lib stdenv ruby; };
    "1.138.0" = import ./1.138.0 { inherit lib stdenv ruby; };
    "1.139.0" = import ./1.139.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-elasticache: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-elasticache: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
