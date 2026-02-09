#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-local
#
# Available versions:
#   0.7.0
#   0.8.0
#   0.9.0
#
# Usage:
#   fog-local { version = "0.9.0"; }
#   fog-local { }  # latest (0.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.0",
  git ? { },
}:
let
  versions = {
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-local: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fog-local: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
