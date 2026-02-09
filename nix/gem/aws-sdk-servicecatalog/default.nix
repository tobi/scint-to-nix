#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-servicecatalog
#
# Available versions:
#   1.124.0
#   1.125.0
#   1.126.0
#
# Usage:
#   aws-sdk-servicecatalog { version = "1.126.0"; }
#   aws-sdk-servicecatalog { }  # latest (1.126.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.126.0",
  git ? { },
}:
let
  versions = {
    "1.124.0" = import ./1.124.0 { inherit lib stdenv ruby; };
    "1.125.0" = import ./1.125.0 { inherit lib stdenv ruby; };
    "1.126.0" = import ./1.126.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-servicecatalog: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-servicecatalog: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
