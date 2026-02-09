#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloudwatch
#
# Available versions:
#   1.127.0
#   1.128.0
#   1.129.0
#
# Usage:
#   aws-sdk-cloudwatch { version = "1.129.0"; }
#   aws-sdk-cloudwatch { }  # latest (1.129.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.129.0",
  git ? { },
}:
let
  versions = {
    "1.127.0" = import ./1.127.0 { inherit lib stdenv ruby; };
    "1.128.0" = import ./1.128.0 { inherit lib stdenv ruby; };
    "1.129.0" = import ./1.129.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloudwatch: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-cloudwatch: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
