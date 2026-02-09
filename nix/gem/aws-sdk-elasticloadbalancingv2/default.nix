#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-elasticloadbalancingv2
#
# Available versions:
#   1.146.0
#   1.147.0
#   1.148.0
#
# Usage:
#   aws-sdk-elasticloadbalancingv2 { version = "1.148.0"; }
#   aws-sdk-elasticloadbalancingv2 { }  # latest (1.148.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.148.0",
  git ? { },
}:
let
  versions = {
    "1.146.0" = import ./1.146.0 { inherit lib stdenv ruby; };
    "1.147.0" = import ./1.147.0 { inherit lib stdenv ruby; };
    "1.148.0" = import ./1.148.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-elasticloadbalancingv2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-elasticloadbalancingv2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
