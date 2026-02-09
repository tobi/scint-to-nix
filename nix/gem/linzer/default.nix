#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# linzer
#
# Available versions:
#   0.7.7
#
# Usage:
#   linzer { version = "0.7.7"; }
#   linzer { }  # latest (0.7.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.7",
  git ? { },
}:
let
  versions = {
    "0.7.7" = import ./0.7.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "linzer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "linzer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
