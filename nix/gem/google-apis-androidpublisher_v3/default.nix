#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-androidpublisher_v3
#
# Available versions:
#   0.94.0
#   0.95.0
#   0.96.0
#
# Usage:
#   google-apis-androidpublisher_v3 { version = "0.96.0"; }
#   google-apis-androidpublisher_v3 { }  # latest (0.96.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.96.0",
  git ? { },
}:
let
  versions = {
    "0.94.0" = import ./0.94.0 { inherit lib stdenv ruby; };
    "0.95.0" = import ./0.95.0 { inherit lib stdenv ruby; };
    "0.96.0" = import ./0.96.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-androidpublisher_v3: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-apis-androidpublisher_v3: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
