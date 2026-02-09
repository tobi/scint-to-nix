#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ram
#
# Available versions:
#   1.82.0
#   1.83.0
#   1.84.0
#
# Usage:
#   aws-sdk-ram { version = "1.84.0"; }
#   aws-sdk-ram { }  # latest (1.84.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.84.0",
  git ? { },
}:
let
  versions = {
    "1.82.0" = import ./1.82.0 { inherit lib stdenv ruby; };
    "1.83.0" = import ./1.83.0 { inherit lib stdenv ruby; };
    "1.84.0" = import ./1.84.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-ram: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-ram: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
