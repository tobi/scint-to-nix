#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# optparse
#
# Available versions:
#   0.7.0
#   0.8.0
#   0.8.1
#
# Usage:
#   optparse { version = "0.8.1"; }
#   optparse { }  # latest (0.8.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.1",
  git ? { },
}:
let
  versions = {
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "optparse: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "optparse: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
