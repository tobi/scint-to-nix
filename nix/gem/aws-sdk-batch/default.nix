#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-batch
#
# Available versions:
#   1.131.0
#   1.132.0
#   1.133.0
#
# Usage:
#   aws-sdk-batch { version = "1.133.0"; }
#   aws-sdk-batch { }  # latest (1.133.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.133.0",
  git ? { },
}:
let
  versions = {
    "1.131.0" = import ./1.131.0 { inherit lib stdenv ruby; };
    "1.132.0" = import ./1.132.0 { inherit lib stdenv ruby; };
    "1.133.0" = import ./1.133.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-batch: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-batch: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
