#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-waf
#
# Available versions:
#   1.88.0
#   1.89.0
#   1.90.0
#
# Usage:
#   aws-sdk-waf { version = "1.90.0"; }
#   aws-sdk-waf { }  # latest (1.90.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.90.0",
  git ? { },
}:
let
  versions = {
    "1.88.0" = import ./1.88.0 { inherit lib stdenv ruby; };
    "1.89.0" = import ./1.89.0 { inherit lib stdenv ruby; };
    "1.90.0" = import ./1.90.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-waf: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-waf: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
