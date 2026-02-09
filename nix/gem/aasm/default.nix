#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aasm
#
# Available versions:
#   5.5.0
#   5.5.1
#   5.5.2
#
# Usage:
#   aasm { version = "5.5.2"; }
#   aasm { }  # latest (5.5.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.5.2",
  git ? { },
}:
let
  versions = {
    "5.5.0" = import ./5.5.0 { inherit lib stdenv ruby; };
    "5.5.1" = import ./5.5.1 { inherit lib stdenv ruby; };
    "5.5.2" = import ./5.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aasm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aasm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
