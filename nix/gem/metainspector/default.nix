#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# metainspector
#
# Available versions:
#   5.15.0
#
# Usage:
#   metainspector { version = "5.15.0"; }
#   metainspector { }  # latest (5.15.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.15.0",
  git ? { },
}:
let
  versions = {
    "5.15.0" = import ./5.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "metainspector: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "metainspector: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
