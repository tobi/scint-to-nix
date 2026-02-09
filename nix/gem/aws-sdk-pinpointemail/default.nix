#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-pinpointemail
#
# Available versions:
#   1.76.0
#   1.77.0
#   1.78.0
#
# Usage:
#   aws-sdk-pinpointemail { version = "1.78.0"; }
#   aws-sdk-pinpointemail { }  # latest (1.78.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.78.0",
  git ? { },
}:
let
  versions = {
    "1.76.0" = import ./1.76.0 { inherit lib stdenv ruby; };
    "1.77.0" = import ./1.77.0 { inherit lib stdenv ruby; };
    "1.78.0" = import ./1.78.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-pinpointemail: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-pinpointemail: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
