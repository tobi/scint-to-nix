#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-glue
#
# Available versions:
#   1.247.0
#   1.248.0
#   1.249.0
#
# Usage:
#   aws-sdk-glue { version = "1.249.0"; }
#   aws-sdk-glue { }  # latest (1.249.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.249.0",
  git ? { },
}:
let
  versions = {
    "1.247.0" = import ./1.247.0 { inherit lib stdenv ruby; };
    "1.248.0" = import ./1.248.0 { inherit lib stdenv ruby; };
    "1.249.0" = import ./1.249.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-glue: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-glue: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
