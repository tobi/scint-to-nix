#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# airbrake
#
# Available versions:
#   13.0.3
#   13.0.4
#   13.0.5
#
# Usage:
#   airbrake { version = "13.0.5"; }
#   airbrake { }  # latest (13.0.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "13.0.5",
  git ? { },
}:
let
  versions = {
    "13.0.3" = import ./13.0.3 { inherit lib stdenv ruby; };
    "13.0.4" = import ./13.0.4 { inherit lib stdenv ruby; };
    "13.0.5" = import ./13.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "airbrake: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "airbrake: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
