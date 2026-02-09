#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-clouddirectory
#
# Available versions:
#   1.84.0
#   1.85.0
#   1.86.0
#
# Usage:
#   aws-sdk-clouddirectory { version = "1.86.0"; }
#   aws-sdk-clouddirectory { }  # latest (1.86.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.86.0",
  git ? { },
}:
let
  versions = {
    "1.84.0" = import ./1.84.0 { inherit lib stdenv ruby; };
    "1.85.0" = import ./1.85.0 { inherit lib stdenv ruby; };
    "1.86.0" = import ./1.86.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-clouddirectory: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-clouddirectory: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
