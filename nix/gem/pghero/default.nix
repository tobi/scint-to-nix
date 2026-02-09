#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pghero
#
# Available versions:
#   3.6.1
#   3.7.0
#
# Usage:
#   pghero { version = "3.7.0"; }
#   pghero { }  # latest (3.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.7.0",
  git ? { },
}:
let
  versions = {
    "3.6.1" = import ./3.6.1 { inherit lib stdenv ruby; };
    "3.7.0" = import ./3.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pghero: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pghero: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
