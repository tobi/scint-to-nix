#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-api-client
#
# Available versions:
#   0.51.0
#   0.52.0
#   0.53.0
#
# Usage:
#   google-api-client { version = "0.53.0"; }
#   google-api-client { }  # latest (0.53.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.53.0",
  git ? { },
}:
let
  versions = {
    "0.51.0" = import ./0.51.0 { inherit lib stdenv ruby; };
    "0.52.0" = import ./0.52.0 { inherit lib stdenv ruby; };
    "0.53.0" = import ./0.53.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-api-client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-api-client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
