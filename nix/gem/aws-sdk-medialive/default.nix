#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-medialive
#
# Available versions:
#   1.176.0
#   1.177.0
#   1.178.0
#
# Usage:
#   aws-sdk-medialive { version = "1.178.0"; }
#   aws-sdk-medialive { }  # latest (1.178.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.178.0",
  git ? { },
}:
let
  versions = {
    "1.176.0" = import ./1.176.0 { inherit lib stdenv ruby; };
    "1.177.0" = import ./1.177.0 { inherit lib stdenv ruby; };
    "1.178.0" = import ./1.178.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-medialive: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-medialive: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
