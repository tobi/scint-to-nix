#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-directoryservice
#
# Available versions:
#   1.98.0
#   1.99.0
#   1.100.0
#
# Usage:
#   aws-sdk-directoryservice { version = "1.100.0"; }
#   aws-sdk-directoryservice { }  # latest (1.100.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.100.0",
  git ? { },
}:
let
  versions = {
    "1.98.0" = import ./1.98.0 { inherit lib stdenv ruby; };
    "1.99.0" = import ./1.99.0 { inherit lib stdenv ruby; };
    "1.100.0" = import ./1.100.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-directoryservice: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-directoryservice: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
