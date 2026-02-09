#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-macie
#
# Available versions:
#   1.46.0
#   1.47.0
#   1.48.0
#
# Usage:
#   aws-sdk-macie { version = "1.48.0"; }
#   aws-sdk-macie { }  # latest (1.48.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.48.0",
  git ? { },
}:
let
  versions = {
    "1.46.0" = import ./1.46.0 { inherit lib stdenv ruby; };
    "1.47.0" = import ./1.47.0 { inherit lib stdenv ruby; };
    "1.48.0" = import ./1.48.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-macie: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-macie: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
