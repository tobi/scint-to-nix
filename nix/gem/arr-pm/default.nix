#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# arr-pm
#
# Available versions:
#   0.0.10
#   0.0.11
#   0.0.12
#
# Usage:
#   arr-pm { version = "0.0.12"; }
#   arr-pm { }  # latest (0.0.12)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.12",
  git ? { },
}:
let
  versions = {
    "0.0.10" = import ./0.0.10 { inherit lib stdenv ruby; };
    "0.0.11" = import ./0.0.11 { inherit lib stdenv ruby; };
    "0.0.12" = import ./0.0.12 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "arr-pm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "arr-pm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
