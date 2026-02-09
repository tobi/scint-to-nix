#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gemoji
#
# Available versions:
#   4.0.0
#   4.0.1
#   4.1.0
#
# Usage:
#   gemoji { version = "4.1.0"; }
#   gemoji { }  # latest (4.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.0",
  git ? { },
}:
let
  versions = {
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.0.1" = import ./4.0.1 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gemoji: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gemoji: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
