#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-eks
#
# Available versions:
#   1.155.0
#   1.156.0
#   1.157.0
#
# Usage:
#   aws-sdk-eks { version = "1.157.0"; }
#   aws-sdk-eks { }  # latest (1.157.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.157.0",
  git ? { },
}:
let
  versions = {
    "1.155.0" = import ./1.155.0 { inherit lib stdenv ruby; };
    "1.156.0" = import ./1.156.0 { inherit lib stdenv ruby; };
    "1.157.0" = import ./1.157.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-eks: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-eks: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
