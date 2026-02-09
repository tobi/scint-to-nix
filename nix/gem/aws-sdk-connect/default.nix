#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-connect
#
# Available versions:
#   1.238.0
#   1.239.0
#   1.240.0
#
# Usage:
#   aws-sdk-connect { version = "1.240.0"; }
#   aws-sdk-connect { }  # latest (1.240.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.240.0",
  git ? { },
}:
let
  versions = {
    "1.238.0" = import ./1.238.0 { inherit lib stdenv ruby; };
    "1.239.0" = import ./1.239.0 { inherit lib stdenv ruby; };
    "1.240.0" = import ./1.240.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-connect: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-connect: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
