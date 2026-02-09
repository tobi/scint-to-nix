#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloudsearchdomain
#
# Available versions:
#   1.67.0
#   1.68.0
#   1.69.0
#
# Usage:
#   aws-sdk-cloudsearchdomain { version = "1.69.0"; }
#   aws-sdk-cloudsearchdomain { }  # latest (1.69.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.69.0",
  git ? { },
}:
let
  versions = {
    "1.67.0" = import ./1.67.0 { inherit lib stdenv ruby; };
    "1.68.0" = import ./1.68.0 { inherit lib stdenv ruby; };
    "1.69.0" = import ./1.69.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloudsearchdomain: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-cloudsearchdomain: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
