#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-quicksight
#
# Available versions:
#   1.170.0
#   1.171.0
#   1.172.0
#
# Usage:
#   aws-sdk-quicksight { version = "1.172.0"; }
#   aws-sdk-quicksight { }  # latest (1.172.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.172.0",
  git ? { },
}:
let
  versions = {
    "1.170.0" = import ./1.170.0 { inherit lib stdenv ruby; };
    "1.171.0" = import ./1.171.0 { inherit lib stdenv ruby; };
    "1.172.0" = import ./1.172.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-quicksight: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-quicksight: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
