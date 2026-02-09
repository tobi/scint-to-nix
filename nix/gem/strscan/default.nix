#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strscan
#
# Available versions:
#   3.1.7
#
# Usage:
#   strscan { version = "3.1.7"; }
#   strscan { }  # latest (3.1.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.7",
  git ? { },
}:
let
  versions = {
    "3.1.7" = import ./3.1.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "strscan: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "strscan: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
