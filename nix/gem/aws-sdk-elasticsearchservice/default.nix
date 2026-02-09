#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-elasticsearchservice
#
# Available versions:
#   1.112.0
#   1.113.0
#   1.114.0
#
# Usage:
#   aws-sdk-elasticsearchservice { version = "1.114.0"; }
#   aws-sdk-elasticsearchservice { }  # latest (1.114.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.114.0",
  git ? { },
}:
let
  versions = {
    "1.112.0" = import ./1.112.0 { inherit lib stdenv ruby; };
    "1.113.0" = import ./1.113.0 { inherit lib stdenv ruby; };
    "1.114.0" = import ./1.114.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-elasticsearchservice: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-elasticsearchservice: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
