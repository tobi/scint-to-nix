#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-savingsplans
#
# Available versions:
#   1.71.0
#   1.72.0
#   1.73.0
#
# Usage:
#   aws-sdk-savingsplans { version = "1.73.0"; }
#   aws-sdk-savingsplans { }  # latest (1.73.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.73.0",
  git ? { },
}:
let
  versions = {
    "1.71.0" = import ./1.71.0 { inherit lib stdenv ruby; };
    "1.72.0" = import ./1.72.0 { inherit lib stdenv ruby; };
    "1.73.0" = import ./1.73.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-savingsplans: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-savingsplans: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
