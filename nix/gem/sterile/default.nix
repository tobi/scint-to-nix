#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sterile
#
# Available versions:
#   1.0.26
#
# Usage:
#   sterile { version = "1.0.26"; }
#   sterile { }  # latest (1.0.26)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.26",
  git ? { },
}:
let
  versions = {
    "1.0.26" = import ./1.0.26 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sterile: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sterile: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
