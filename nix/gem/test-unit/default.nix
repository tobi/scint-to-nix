#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# test-unit
#
# Available versions:
#   3.7.5
#   3.7.6
#   3.7.7
#
# Usage:
#   test-unit { version = "3.7.7"; }
#   test-unit { }  # latest (3.7.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.7.7",
  git ? { },
}:
let
  versions = {
    "3.7.5" = import ./3.7.5 { inherit lib stdenv ruby; };
    "3.7.6" = import ./3.7.6 { inherit lib stdenv ruby; };
    "3.7.7" = import ./3.7.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "test-unit: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "test-unit: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
