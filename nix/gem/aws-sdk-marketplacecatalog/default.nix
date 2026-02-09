#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-marketplacecatalog
#
# Available versions:
#   1.73.0
#   1.74.0
#   1.75.0
#
# Usage:
#   aws-sdk-marketplacecatalog { version = "1.75.0"; }
#   aws-sdk-marketplacecatalog { }  # latest (1.75.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.75.0",
  git ? { },
}:
let
  versions = {
    "1.73.0" = import ./1.73.0 { inherit lib stdenv ruby; };
    "1.74.0" = import ./1.74.0 { inherit lib stdenv ruby; };
    "1.75.0" = import ./1.75.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-marketplacecatalog: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-marketplacecatalog: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
