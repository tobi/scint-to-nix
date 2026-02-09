#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-athena
#
# Available versions:
#   1.115.0
#   1.116.0
#   1.117.0
#
# Usage:
#   aws-sdk-athena { version = "1.117.0"; }
#   aws-sdk-athena { }  # latest (1.117.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.117.0",
  git ? { },
}:
let
  versions = {
    "1.115.0" = import ./1.115.0 { inherit lib stdenv ruby; };
    "1.116.0" = import ./1.116.0 { inherit lib stdenv ruby; };
    "1.117.0" = import ./1.117.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-athena: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-athena: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
