#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloudformation
#
# Available versions:
#   1.147.0
#   1.148.0
#   1.149.0
#
# Usage:
#   aws-sdk-cloudformation { version = "1.149.0"; }
#   aws-sdk-cloudformation { }  # latest (1.149.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.149.0",
  git ? { },
}:
let
  versions = {
    "1.147.0" = import ./1.147.0 { inherit lib stdenv ruby; };
    "1.148.0" = import ./1.148.0 { inherit lib stdenv ruby; };
    "1.149.0" = import ./1.149.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloudformation: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-cloudformation: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
