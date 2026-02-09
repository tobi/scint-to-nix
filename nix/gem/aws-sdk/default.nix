#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk
#
# Available versions:
#   3.1.0
#   3.2.0
#   3.3.0
#
# Usage:
#   aws-sdk { version = "3.3.0"; }
#   aws-sdk { }  # latest (3.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.0",
  git ? { },
}:
let
  versions = {
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
    "3.3.0" = import ./3.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
