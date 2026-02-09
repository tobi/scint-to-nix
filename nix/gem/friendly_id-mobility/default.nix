#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# friendly_id-mobility
#
# Available versions:
#   1.0.5
#
# Usage:
#   friendly_id-mobility { version = "1.0.5"; }
#   friendly_id-mobility { }  # latest (1.0.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.5",
  git ? { },
}:
let
  versions = {
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "friendly_id-mobility: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "friendly_id-mobility: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
