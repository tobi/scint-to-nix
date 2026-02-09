#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-organizations
#
# Available versions:
#   1.133.0
#   1.134.0
#   1.135.0
#
# Usage:
#   aws-sdk-organizations { version = "1.135.0"; }
#   aws-sdk-organizations { }  # latest (1.135.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.135.0",
  git ? { },
}:
let
  versions = {
    "1.133.0" = import ./1.133.0 { inherit lib stdenv ruby; };
    "1.134.0" = import ./1.134.0 { inherit lib stdenv ruby; };
    "1.135.0" = import ./1.135.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-organizations: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-organizations: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
