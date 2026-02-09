#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gibbon
#
# Available versions:
#   3.5.0
#
# Usage:
#   gibbon { version = "3.5.0"; }
#   gibbon { }  # latest (3.5.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.0",
  git ? { },
}:
let
  versions = {
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gibbon: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gibbon: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
