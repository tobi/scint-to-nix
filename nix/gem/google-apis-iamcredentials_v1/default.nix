#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-iamcredentials_v1
#
# Available versions:
#   0.22.0
#   0.24.0
#   0.25.0
#   0.26.0
#
# Usage:
#   google-apis-iamcredentials_v1 { version = "0.26.0"; }
#   google-apis-iamcredentials_v1 { }  # latest (0.26.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.0",
  git ? { },
}:
let
  versions = {
    "0.22.0" = import ./0.22.0 { inherit lib stdenv ruby; };
    "0.24.0" = import ./0.24.0 { inherit lib stdenv ruby; };
    "0.25.0" = import ./0.25.0 { inherit lib stdenv ruby; };
    "0.26.0" = import ./0.26.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-iamcredentials_v1: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-apis-iamcredentials_v1: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
