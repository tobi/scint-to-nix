#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# counter_culture
#
# Available versions:
#   3.5.3
#
# Usage:
#   counter_culture { version = "3.5.3"; }
#   counter_culture { }  # latest (3.5.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.3",
  git ? { },
}:
let
  versions = {
    "3.5.3" = import ./3.5.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "counter_culture: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "counter_culture: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
