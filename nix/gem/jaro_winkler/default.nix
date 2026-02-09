#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jaro_winkler
#
# Available versions:
#   1.5.6
#   1.6.0
#   1.6.1
#
# Usage:
#   jaro_winkler { version = "1.6.1"; }
#   jaro_winkler { }  # latest (1.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.1",
  git ? { },
}:
let
  versions = {
    "1.5.6" = import ./1.5.6 { inherit lib stdenv ruby; };
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
    "1.6.1" = import ./1.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jaro_winkler: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jaro_winkler: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
