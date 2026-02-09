#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# config
#
# Available versions:
#   5.5.2
#   5.6.0
#   5.6.1
#
# Usage:
#   config { version = "5.6.1"; }
#   config { }  # latest (5.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.6.1",
  git ? { },
}:
let
  versions = {
    "5.5.2" = import ./5.5.2 { inherit lib stdenv ruby; };
    "5.6.0" = import ./5.6.0 { inherit lib stdenv ruby; };
    "5.6.1" = import ./5.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "config: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "config: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
