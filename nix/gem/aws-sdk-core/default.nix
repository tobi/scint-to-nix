#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-core
#
# Available versions:
#   3.227.0
#   3.230.0
#   3.240.0
#   3.241.3
#   3.241.4
#   3.242.0
#
# Usage:
#   aws-sdk-core { version = "3.242.0"; }
#   aws-sdk-core { }  # latest (3.242.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.242.0",
  git ? { },
}:
let
  versions = {
    "3.227.0" = import ./3.227.0 { inherit lib stdenv ruby; };
    "3.230.0" = import ./3.230.0 { inherit lib stdenv ruby; };
    "3.240.0" = import ./3.240.0 { inherit lib stdenv ruby; };
    "3.241.3" = import ./3.241.3 { inherit lib stdenv ruby; };
    "3.241.4" = import ./3.241.4 { inherit lib stdenv ruby; };
    "3.242.0" = import ./3.242.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
