#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-docdb
#
# Available versions:
#   1.99.0
#   1.100.0
#   1.101.0
#
# Usage:
#   aws-sdk-docdb { version = "1.101.0"; }
#   aws-sdk-docdb { }  # latest (1.101.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.101.0",
  git ? { },
}:
let
  versions = {
    "1.99.0" = import ./1.99.0 { inherit lib stdenv ruby; };
    "1.100.0" = import ./1.100.0 { inherit lib stdenv ruby; };
    "1.101.0" = import ./1.101.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-docdb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-docdb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
