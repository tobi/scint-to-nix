#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capistrano
#
# Available versions:
#   3.19.1
#   3.19.2
#   3.20.0
#
# Usage:
#   capistrano { version = "3.20.0"; }
#   capistrano { }  # latest (3.20.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.20.0",
  git ? { },
}:
let
  versions = {
    "3.19.1" = import ./3.19.1 { inherit lib stdenv ruby; };
    "3.19.2" = import ./3.19.2 { inherit lib stdenv ruby; };
    "3.20.0" = import ./3.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "capistrano: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "capistrano: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
