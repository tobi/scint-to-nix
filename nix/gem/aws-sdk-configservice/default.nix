#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-configservice
#
# Available versions:
#   1.144.0
#   1.145.0
#   1.146.0
#
# Usage:
#   aws-sdk-configservice { version = "1.146.0"; }
#   aws-sdk-configservice { }  # latest (1.146.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.146.0",
  git ? { },
}:
let
  versions = {
    "1.144.0" = import ./1.144.0 { inherit lib stdenv ruby; };
    "1.145.0" = import ./1.145.0 { inherit lib stdenv ruby; };
    "1.146.0" = import ./1.146.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-configservice: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-configservice: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
