#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ec2
#
# Available versions:
#   1.595.0
#   1.596.0
#   1.597.0
#
# Usage:
#   aws-sdk-ec2 { version = "1.597.0"; }
#   aws-sdk-ec2 { }  # latest (1.597.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.597.0",
  git ? { },
}:
let
  versions = {
    "1.595.0" = import ./1.595.0 { inherit lib stdenv ruby; };
    "1.596.0" = import ./1.596.0 { inherit lib stdenv ruby; };
    "1.597.0" = import ./1.597.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-ec2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-ec2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
