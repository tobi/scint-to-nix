#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# babel-transpiler
#
# Available versions:
#   0.6.0
#   0.7.0
#
# Usage:
#   babel-transpiler { version = "0.7.0"; }
#   babel-transpiler { }  # latest (0.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.0",
  git ? { },
}:
let
  versions = {
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "babel-transpiler: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "babel-transpiler: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
