#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloud9
#
# Available versions:
#   1.97.0
#   1.98.0
#   1.99.0
#
# Usage:
#   aws-sdk-cloud9 { version = "1.99.0"; }
#   aws-sdk-cloud9 { }  # latest (1.99.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.99.0",
  git ? { },
}:
let
  versions = {
    "1.97.0" = import ./1.97.0 { inherit lib stdenv ruby; };
    "1.98.0" = import ./1.98.0 { inherit lib stdenv ruby; };
    "1.99.0" = import ./1.99.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloud9: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-cloud9: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
