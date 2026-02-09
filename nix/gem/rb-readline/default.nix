#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-readline
#
# Available versions:
#   0.5.3
#   0.5.4
#   0.5.5
#
# Usage:
#   rb-readline { version = "0.5.5"; }
#   rb-readline { }  # latest (0.5.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.5",
  git ? { },
}:
let
  versions = {
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby; };
    "0.5.4" = import ./0.5.4 { inherit lib stdenv ruby; };
    "0.5.5" = import ./0.5.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb-readline: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rb-readline: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
