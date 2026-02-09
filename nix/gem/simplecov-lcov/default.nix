#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov-lcov
#
# Available versions:
#   0.9.0
#
# Usage:
#   simplecov-lcov { version = "0.9.0"; }
#   simplecov-lcov { }  # latest (0.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.0",
  git ? { },
}:
let
  versions = {
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simplecov-lcov: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "simplecov-lcov: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
