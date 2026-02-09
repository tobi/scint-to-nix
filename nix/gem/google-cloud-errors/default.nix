#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-errors
#
# Available versions:
#   1.3.1
#   1.4.0
#   1.5.0
#
# Usage:
#   google-cloud-errors { version = "1.5.0"; }
#   google-cloud-errors { }  # latest (1.5.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.5.0",
  git ? { },
}:
let
  versions = {
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
    "1.5.0" = import ./1.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-errors: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-cloud-errors: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
