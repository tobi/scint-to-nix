#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-securityhub
#
# Available versions:
#   1.149.0
#   1.150.0
#   1.151.0
#
# Usage:
#   aws-sdk-securityhub { version = "1.151.0"; }
#   aws-sdk-securityhub { }  # latest (1.151.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.151.0",
  git ? { },
}:
let
  versions = {
    "1.149.0" = import ./1.149.0 { inherit lib stdenv ruby; };
    "1.150.0" = import ./1.150.0 { inherit lib stdenv ruby; };
    "1.151.0" = import ./1.151.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-securityhub: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-securityhub: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
