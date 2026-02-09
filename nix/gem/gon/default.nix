#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gon
#
# Available versions:
#   6.5.0
#   6.6.0
#   7.0.0
#
# Usage:
#   gon { version = "7.0.0"; }
#   gon { }  # latest (7.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.0",
  git ? { },
}:
let
  versions = {
    "6.5.0" = import ./6.5.0 { inherit lib stdenv ruby; };
    "6.6.0" = import ./6.6.0 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gon: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gon: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
