#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# friendly_id
#
# Available versions:
#   5.5.0
#   5.5.1
#   5.6.0
#
# Usage:
#   friendly_id { version = "5.6.0"; }
#   friendly_id { }  # latest (5.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.6.0",
  git ? { },
}:
let
  versions = {
    "5.5.0" = import ./5.5.0 { inherit lib stdenv ruby; };
    "5.5.1" = import ./5.5.1 { inherit lib stdenv ruby; };
    "5.6.0" = import ./5.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "friendly_id: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "friendly_id: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
