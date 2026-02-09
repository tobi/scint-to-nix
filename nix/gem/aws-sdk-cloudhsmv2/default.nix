#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloudhsmv2
#
# Available versions:
#   1.86.0
#   1.87.0
#   1.88.0
#
# Usage:
#   aws-sdk-cloudhsmv2 { version = "1.88.0"; }
#   aws-sdk-cloudhsmv2 { }  # latest (1.88.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.88.0",
  git ? { },
}:
let
  versions = {
    "1.86.0" = import ./1.86.0 { inherit lib stdenv ruby; };
    "1.87.0" = import ./1.87.0 { inherit lib stdenv ruby; };
    "1.88.0" = import ./1.88.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloudhsmv2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-cloudhsmv2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
