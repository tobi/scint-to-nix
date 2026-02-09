#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-workmail
#
# Available versions:
#   1.94.0
#   1.95.0
#   1.96.0
#
# Usage:
#   aws-sdk-workmail { version = "1.96.0"; }
#   aws-sdk-workmail { }  # latest (1.96.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.96.0",
  git ? { },
}:
let
  versions = {
    "1.94.0" = import ./1.94.0 { inherit lib stdenv ruby; };
    "1.95.0" = import ./1.95.0 { inherit lib stdenv ruby; };
    "1.96.0" = import ./1.96.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-workmail: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-workmail: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
