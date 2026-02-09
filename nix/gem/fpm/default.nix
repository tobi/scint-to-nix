#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fpm
#
# Available versions:
#   1.15.1
#   1.16.0
#   1.17.0
#
# Usage:
#   fpm { version = "1.17.0"; }
#   fpm { }  # latest (1.17.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.17.0",
  git ? { },
}:
let
  versions = {
    "1.15.1" = import ./1.15.1 { inherit lib stdenv ruby; };
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fpm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fpm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
