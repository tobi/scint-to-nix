#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# guard
#
# Available versions:
#   2.18.1
#   2.19.1
#   2.20.0
#   2.20.1
#
# Usage:
#   guard { version = "2.20.1"; }
#   guard { }  # latest (2.20.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.20.1",
  git ? { },
}:
let
  versions = {
    "2.18.1" = import ./2.18.1 { inherit lib stdenv ruby; };
    "2.19.1" = import ./2.19.1 { inherit lib stdenv ruby; };
    "2.20.0" = import ./2.20.0 { inherit lib stdenv ruby; };
    "2.20.1" = import ./2.20.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "guard: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "guard: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
