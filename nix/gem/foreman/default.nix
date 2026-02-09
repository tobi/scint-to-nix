#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# foreman
#
# Available versions:
#   0.87.2
#   0.88.1
#   0.89.1
#   0.90.0
#
# Usage:
#   foreman { version = "0.90.0"; }
#   foreman { }  # latest (0.90.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.90.0",
  git ? { },
}:
let
  versions = {
    "0.87.2" = import ./0.87.2 { inherit lib stdenv ruby; };
    "0.88.1" = import ./0.88.1 { inherit lib stdenv ruby; };
    "0.89.1" = import ./0.89.1 { inherit lib stdenv ruby; };
    "0.90.0" = import ./0.90.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "foreman: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "foreman: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
