#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-config
#
# Available versions:
#   3.0.6
#   3.0.9
#   3.0.27
#
# Usage:
#   mixlib-config { version = "3.0.27"; }
#   mixlib-config { }  # latest (3.0.27)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.27",
  git ? { },
}:
let
  versions = {
    "3.0.6" = import ./3.0.6 { inherit lib stdenv ruby; };
    "3.0.9" = import ./3.0.9 { inherit lib stdenv ruby; };
    "3.0.27" = import ./3.0.27 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mixlib-config: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mixlib-config: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
