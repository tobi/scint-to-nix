#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-personalize
#
# Available versions:
#   1.93.0
#   1.94.0
#   1.95.0
#
# Usage:
#   aws-sdk-personalize { version = "1.95.0"; }
#   aws-sdk-personalize { }  # latest (1.95.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.95.0",
  git ? { },
}:
let
  versions = {
    "1.93.0" = import ./1.93.0 { inherit lib stdenv ruby; };
    "1.94.0" = import ./1.94.0 { inherit lib stdenv ruby; };
    "1.95.0" = import ./1.95.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-personalize: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-personalize: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
