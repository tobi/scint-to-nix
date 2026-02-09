#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-dax
#
# Available versions:
#   1.81.0
#   1.82.0
#   1.83.0
#
# Usage:
#   aws-sdk-dax { version = "1.83.0"; }
#   aws-sdk-dax { }  # latest (1.83.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.83.0",
  git ? { },
}:
let
  versions = {
    "1.81.0" = import ./1.81.0 { inherit lib stdenv ruby; };
    "1.82.0" = import ./1.82.0 { inherit lib stdenv ruby; };
    "1.83.0" = import ./1.83.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-dax: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-dax: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
