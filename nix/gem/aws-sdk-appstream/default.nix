#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-appstream
#
# Available versions:
#   1.125.0
#   1.126.0
#   1.127.0
#
# Usage:
#   aws-sdk-appstream { version = "1.127.0"; }
#   aws-sdk-appstream { }  # latest (1.127.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.127.0",
  git ? { },
}:
let
  versions = {
    "1.125.0" = import ./1.125.0 { inherit lib stdenv ruby; };
    "1.126.0" = import ./1.126.0 { inherit lib stdenv ruby; };
    "1.127.0" = import ./1.127.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-appstream: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-appstream: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
