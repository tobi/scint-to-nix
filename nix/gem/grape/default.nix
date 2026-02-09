#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grape
#
# Available versions:
#   3.0.1
#   3.1.0
#   3.1.1
#
# Usage:
#   grape { version = "3.1.1"; }
#   grape { }  # latest (3.1.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.1",
  git ? { },
}:
let
  versions = {
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.1.1" = import ./3.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "grape: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "grape: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
