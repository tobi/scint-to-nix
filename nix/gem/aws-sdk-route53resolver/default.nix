#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-route53resolver
#
# Available versions:
#   1.92.0
#   1.93.0
#   1.94.0
#
# Usage:
#   aws-sdk-route53resolver { version = "1.94.0"; }
#   aws-sdk-route53resolver { }  # latest (1.94.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.94.0",
  git ? { },
}:
let
  versions = {
    "1.92.0" = import ./1.92.0 { inherit lib stdenv ruby; };
    "1.93.0" = import ./1.93.0 { inherit lib stdenv ruby; };
    "1.94.0" = import ./1.94.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-route53resolver: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-route53resolver: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
