#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# citrus
#
# Available versions:
#   3.0.0
#   3.0.1
#   3.0.2
#
# Usage:
#   citrus { version = "3.0.2"; }
#   citrus { }  # latest (3.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.2",
  git ? { },
}:
let
  versions = {
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "3.0.2" = import ./3.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "citrus: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "citrus: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
