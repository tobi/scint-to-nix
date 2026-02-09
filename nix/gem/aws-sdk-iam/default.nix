#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iam
#
# Available versions:
#   1.138.0
#   1.139.0
#   1.140.0
#
# Usage:
#   aws-sdk-iam { version = "1.140.0"; }
#   aws-sdk-iam { }  # latest (1.140.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.140.0",
  git ? { },
}:
let
  versions = {
    "1.138.0" = import ./1.138.0 { inherit lib stdenv ruby; };
    "1.139.0" = import ./1.139.0 { inherit lib stdenv ruby; };
    "1.140.0" = import ./1.140.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iam: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-iam: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
