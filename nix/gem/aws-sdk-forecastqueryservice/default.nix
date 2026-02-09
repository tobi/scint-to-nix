#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-forecastqueryservice
#
# Available versions:
#   1.64.0
#   1.65.0
#   1.66.0
#
# Usage:
#   aws-sdk-forecastqueryservice { version = "1.66.0"; }
#   aws-sdk-forecastqueryservice { }  # latest (1.66.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.66.0",
  git ? { },
}:
let
  versions = {
    "1.64.0" = import ./1.64.0 { inherit lib stdenv ruby; };
    "1.65.0" = import ./1.65.0 { inherit lib stdenv ruby; };
    "1.66.0" = import ./1.66.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-forecastqueryservice: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-forecastqueryservice: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
