#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ecs
#
# Available versions:
#   1.218.0
#   1.219.0
#   1.220.0
#
# Usage:
#   aws-sdk-ecs { version = "1.220.0"; }
#   aws-sdk-ecs { }  # latest (1.220.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.220.0",
  git ? { },
}:
let
  versions = {
    "1.218.0" = import ./1.218.0 { inherit lib stdenv ruby; };
    "1.219.0" = import ./1.219.0 { inherit lib stdenv ruby; };
    "1.220.0" = import ./1.220.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-ecs: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-ecs: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
