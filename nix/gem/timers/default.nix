#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timers
#
# Available versions:
#   4.3.4
#   4.3.5
#   4.4.0
#
# Usage:
#   timers { version = "4.4.0"; }
#   timers { }  # latest (4.4.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.0",
  git ? { },
}:
let
  versions = {
    "4.3.4" = import ./4.3.4 { inherit lib stdenv ruby; };
    "4.3.5" = import ./4.3.5 { inherit lib stdenv ruby; };
    "4.4.0" = import ./4.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "timers: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "timers: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
