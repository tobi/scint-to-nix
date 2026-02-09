#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-applicationinsights
#
# Available versions:
#   1.74.0
#   1.75.0
#   1.76.0
#
# Usage:
#   aws-sdk-applicationinsights { version = "1.76.0"; }
#   aws-sdk-applicationinsights { }  # latest (1.76.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.76.0",
  git ? { },
}:
let
  versions = {
    "1.74.0" = import ./1.74.0 { inherit lib stdenv ruby; };
    "1.75.0" = import ./1.75.0 { inherit lib stdenv ruby; };
    "1.76.0" = import ./1.76.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-applicationinsights: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-applicationinsights: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
