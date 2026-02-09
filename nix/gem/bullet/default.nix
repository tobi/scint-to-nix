#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bullet
#
# Available versions:
#   7.1.6
#   8.0.7
#   8.0.8
#   8.1.0
#
# Usage:
#   bullet { version = "8.1.0"; }
#   bullet { }  # latest (8.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.1.0",
  git ? { },
}:
let
  versions = {
    "7.1.6" = import ./7.1.6 { inherit lib stdenv ruby; };
    "8.0.7" = import ./8.0.7 { inherit lib stdenv ruby; };
    "8.0.8" = import ./8.0.8 { inherit lib stdenv ruby; };
    "8.1.0" = import ./8.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bullet: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bullet: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
