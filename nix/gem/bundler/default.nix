#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bundler
#
# Available versions:
#   4.0.4
#   4.0.5
#   4.0.6
#
# Usage:
#   bundler { version = "4.0.6"; }
#   bundler { }  # latest (4.0.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.6",
  git ? { },
}:
let
  versions = {
    "4.0.4" = import ./4.0.4 { inherit lib stdenv ruby; };
    "4.0.5" = import ./4.0.5 { inherit lib stdenv ruby; };
    "4.0.6" = import ./4.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bundler: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bundler: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
