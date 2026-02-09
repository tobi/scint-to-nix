#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-lambdapreview
#
# Available versions:
#   1.48.0
#   1.49.0
#   1.50.0
#
# Usage:
#   aws-sdk-lambdapreview { version = "1.50.0"; }
#   aws-sdk-lambdapreview { }  # latest (1.50.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.50.0",
  git ? { },
}:
let
  versions = {
    "1.48.0" = import ./1.48.0 { inherit lib stdenv ruby; };
    "1.49.0" = import ./1.49.0 { inherit lib stdenv ruby; };
    "1.50.0" = import ./1.50.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-lambdapreview: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-lambdapreview: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
