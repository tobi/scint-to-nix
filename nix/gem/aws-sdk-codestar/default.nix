#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-codestar
#
# Available versions:
#   1.57.0
#   1.58.0
#   1.59.0
#
# Usage:
#   aws-sdk-codestar { version = "1.59.0"; }
#   aws-sdk-codestar { }  # latest (1.59.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.59.0",
  git ? { },
}:
let
  versions = {
    "1.57.0" = import ./1.57.0 { inherit lib stdenv ruby; };
    "1.58.0" = import ./1.58.0 { inherit lib stdenv ruby; };
    "1.59.0" = import ./1.59.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-codestar: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-codestar: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
