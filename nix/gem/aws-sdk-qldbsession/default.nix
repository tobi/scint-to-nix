#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-qldbsession
#
# Available versions:
#   1.60.0
#   1.61.0
#   1.62.0
#
# Usage:
#   aws-sdk-qldbsession { version = "1.62.0"; }
#   aws-sdk-qldbsession { }  # latest (1.62.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.62.0",
  git ? { },
}:
let
  versions = {
    "1.60.0" = import ./1.60.0 { inherit lib stdenv ruby; };
    "1.61.0" = import ./1.61.0 { inherit lib stdenv ruby; };
    "1.62.0" = import ./1.62.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-qldbsession: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-qldbsession: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
