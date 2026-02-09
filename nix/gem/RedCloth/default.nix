#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# RedCloth
#
# Available versions:
#   4.3.2
#   4.3.3
#   4.3.4
#
# Usage:
#   RedCloth { version = "4.3.4"; }
#   RedCloth { }  # latest (4.3.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.3.4",
  git ? { },
}:
let
  versions = {
    "4.3.2" = import ./4.3.2 { inherit lib stdenv ruby; };
    "4.3.3" = import ./4.3.3 { inherit lib stdenv ruby; };
    "4.3.4" = import ./4.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "RedCloth: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "RedCloth: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
