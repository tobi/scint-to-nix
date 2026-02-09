#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_girl_rails
#
# Available versions:
#   4.7.0
#   4.8.0
#   4.9.0
#
# Usage:
#   factory_girl_rails { version = "4.9.0"; }
#   factory_girl_rails { }  # latest (4.9.0)
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
    "4.7.0" = import ./4.7.0 { inherit lib stdenv ruby; };
    "4.8.0" = import ./4.8.0 { inherit lib stdenv ruby; };
    "4.9.0" = import ./4.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_girl_rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "factory_girl_rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
