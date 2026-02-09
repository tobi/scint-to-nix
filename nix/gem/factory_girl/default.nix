#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_girl
#
# Available versions:
#   4.8.0
#   4.8.1
#   4.9.0
#
# Usage:
#   factory_girl { version = "4.9.0"; }
#   factory_girl { }  # latest (4.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.9.0",
  git ? { },
}:
let
  versions = {
    "4.8.0" = import ./4.8.0 { inherit lib stdenv ruby; };
    "4.8.1" = import ./4.8.1 { inherit lib stdenv ruby; };
    "4.9.0" = import ./4.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_girl: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "factory_girl: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
