#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-licensemanager
#
# Available versions:
#   1.85.0
#   1.86.0
#   1.87.0
#
# Usage:
#   aws-sdk-licensemanager { version = "1.87.0"; }
#   aws-sdk-licensemanager { }  # latest (1.87.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.87.0",
  git ? { },
}:
let
  versions = {
    "1.85.0" = import ./1.85.0 { inherit lib stdenv ruby; };
    "1.86.0" = import ./1.86.0 { inherit lib stdenv ruby; };
    "1.87.0" = import ./1.87.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-licensemanager: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-licensemanager: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
