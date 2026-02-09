#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ancestry
#
# Available versions:
#   4.3.3
#
# Usage:
#   ancestry { version = "4.3.3"; }
#   ancestry { }  # latest (4.3.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.3.3",
  git ? { },
}:
let
  versions = {
    "4.3.3" = import ./4.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ancestry: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ancestry: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
