#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-frauddetector
#
# Available versions:
#   1.80.0
#   1.81.0
#   1.82.0
#
# Usage:
#   aws-sdk-frauddetector { version = "1.82.0"; }
#   aws-sdk-frauddetector { }  # latest (1.82.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.82.0",
  git ? { },
}:
let
  versions = {
    "1.80.0" = import ./1.80.0 { inherit lib stdenv ruby; };
    "1.81.0" = import ./1.81.0 { inherit lib stdenv ruby; };
    "1.82.0" = import ./1.82.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-frauddetector: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-frauddetector: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
