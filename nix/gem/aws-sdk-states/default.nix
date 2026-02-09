#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-states
#
# Available versions:
#   1.102.0
#   1.103.0
#   1.104.0
#
# Usage:
#   aws-sdk-states { version = "1.104.0"; }
#   aws-sdk-states { }  # latest (1.104.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.104.0",
  git ? { },
}:
let
  versions = {
    "1.102.0" = import ./1.102.0 { inherit lib stdenv ruby; };
    "1.103.0" = import ./1.103.0 { inherit lib stdenv ruby; };
    "1.104.0" = import ./1.104.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-states: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-states: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
