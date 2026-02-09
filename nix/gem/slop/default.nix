#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slop
#
# Available versions:
#   4.9.3
#   4.10.0
#   4.10.1
#
# Usage:
#   slop { version = "4.10.1"; }
#   slop { }  # latest (4.10.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.10.1",
  git ? { },
}:
let
  versions = {
    "4.9.3" = import ./4.9.3 { inherit lib stdenv ruby; };
    "4.10.0" = import ./4.10.0 { inherit lib stdenv ruby; };
    "4.10.1" = import ./4.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "slop: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "slop: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
