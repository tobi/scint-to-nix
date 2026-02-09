#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-lightsail
#
# Available versions:
#   1.122.0
#   1.123.0
#   1.124.0
#
# Usage:
#   aws-sdk-lightsail { version = "1.124.0"; }
#   aws-sdk-lightsail { }  # latest (1.124.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.124.0",
  git ? { },
}:
let
  versions = {
    "1.122.0" = import ./1.122.0 { inherit lib stdenv ruby; };
    "1.123.0" = import ./1.123.0 { inherit lib stdenv ruby; };
    "1.124.0" = import ./1.124.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-lightsail: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-lightsail: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
