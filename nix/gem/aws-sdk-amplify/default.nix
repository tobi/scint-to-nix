#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-amplify
#
# Available versions:
#   1.96.0
#   1.97.0
#   1.98.0
#
# Usage:
#   aws-sdk-amplify { version = "1.98.0"; }
#   aws-sdk-amplify { }  # latest (1.98.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.98.0",
  git ? { },
}:
let
  versions = {
    "1.96.0" = import ./1.96.0 { inherit lib stdenv ruby; };
    "1.97.0" = import ./1.97.0 { inherit lib stdenv ruby; };
    "1.98.0" = import ./1.98.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-amplify: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-amplify: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
