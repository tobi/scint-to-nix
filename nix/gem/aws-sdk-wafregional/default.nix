#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-wafregional
#
# Available versions:
#   1.89.0
#   1.90.0
#   1.91.0
#
# Usage:
#   aws-sdk-wafregional { version = "1.91.0"; }
#   aws-sdk-wafregional { }  # latest (1.91.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.91.0",
  git ? { },
}:
let
  versions = {
    "1.89.0" = import ./1.89.0 { inherit lib stdenv ruby; };
    "1.90.0" = import ./1.90.0 { inherit lib stdenv ruby; };
    "1.91.0" = import ./1.91.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-wafregional: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-wafregional: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
