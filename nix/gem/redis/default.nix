#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis
#
# Available versions:
#   4.7.1
#   4.8.1
#   5.0.6
#   5.3.0
#   5.4.0
#   5.4.1
#
# Usage:
#   redis { version = "5.4.1"; }
#   redis { }  # latest (5.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.1",
  git ? { },
}:
let
  versions = {
    "4.7.1" = import ./4.7.1 { inherit lib stdenv ruby; };
    "4.8.1" = import ./4.8.1 { inherit lib stdenv ruby; };
    "5.0.6" = import ./5.0.6 { inherit lib stdenv ruby; };
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
    "5.4.1" = import ./5.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
