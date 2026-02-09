#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grpc-google-iam-v1
#
# Available versions:
#   1.9.0
#   1.10.0
#   1.11.0
#
# Usage:
#   grpc-google-iam-v1 { version = "1.11.0"; }
#   grpc-google-iam-v1 { }  # latest (1.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.0",
  git ? { },
}:
let
  versions = {
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "grpc-google-iam-v1: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "grpc-google-iam-v1: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
