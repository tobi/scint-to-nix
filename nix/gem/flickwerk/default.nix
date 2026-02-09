#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flickwerk
#
# Available versions:
#   0.3.6
#
# Usage:
#   flickwerk { version = "0.3.6"; }
#   flickwerk { }  # latest (0.3.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.6",
  git ? { },
}:
let
  versions = {
    "0.3.6" = import ./0.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flickwerk: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "flickwerk: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
