#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-storagegateway
#
# Available versions:
#   1.121.0
#   1.122.0
#   1.123.0
#
# Usage:
#   aws-sdk-storagegateway { version = "1.123.0"; }
#   aws-sdk-storagegateway { }  # latest (1.123.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.123.0",
  git ? { },
}:
let
  versions = {
    "1.121.0" = import ./1.121.0 { inherit lib stdenv ruby; };
    "1.122.0" = import ./1.122.0 { inherit lib stdenv ruby; };
    "1.123.0" = import ./1.123.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-storagegateway: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-storagegateway: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
