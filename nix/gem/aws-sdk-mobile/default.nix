#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-mobile
#
# Available versions:
#   1.53.0
#   1.54.0
#   1.55.0
#
# Usage:
#   aws-sdk-mobile { version = "1.55.0"; }
#   aws-sdk-mobile { }  # latest (1.55.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.55.0",
  git ? { },
}:
let
  versions = {
    "1.53.0" = import ./1.53.0 { inherit lib stdenv ruby; };
    "1.54.0" = import ./1.54.0 { inherit lib stdenv ruby; };
    "1.55.0" = import ./1.55.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-mobile: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-mobile: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
