#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-firehose
#
# Available versions:
#   1.103.0
#   1.104.0
#   1.105.0
#
# Usage:
#   aws-sdk-firehose { version = "1.105.0"; }
#   aws-sdk-firehose { }  # latest (1.105.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.105.0",
  git ? { },
}:
let
  versions = {
    "1.103.0" = import ./1.103.0 { inherit lib stdenv ruby; };
    "1.104.0" = import ./1.104.0 { inherit lib stdenv ruby; };
    "1.105.0" = import ./1.105.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-firehose: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-firehose: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
