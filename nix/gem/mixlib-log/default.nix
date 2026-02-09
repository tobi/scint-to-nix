#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-log
#
# Available versions:
#   3.1.2.1
#   3.2.0
#   3.2.3
#
# Usage:
#   mixlib-log { version = "3.2.3"; }
#   mixlib-log { }  # latest (3.2.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.3",
  git ? { },
}:
let
  versions = {
    "3.1.2.1" = import ./3.1.2.1 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mixlib-log: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mixlib-log: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
