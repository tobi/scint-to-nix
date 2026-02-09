#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-comprehendmedical
#
# Available versions:
#   1.78.0
#   1.79.0
#   1.80.0
#
# Usage:
#   aws-sdk-comprehendmedical { version = "1.80.0"; }
#   aws-sdk-comprehendmedical { }  # latest (1.80.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.80.0",
  git ? { },
}:
let
  versions = {
    "1.78.0" = import ./1.78.0 { inherit lib stdenv ruby; };
    "1.79.0" = import ./1.79.0 { inherit lib stdenv ruby; };
    "1.80.0" = import ./1.80.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-comprehendmedical: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-comprehendmedical: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
