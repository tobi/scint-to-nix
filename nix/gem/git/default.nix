#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# git
#
# Available versions:
#   4.1.2
#   4.2.0
#   4.3.0
#
# Usage:
#   git { version = "4.3.0"; }
#   git { }  # latest (4.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.3.0",
  git ? { },
}:
let
  versions = {
    "4.1.2" = import ./4.1.2 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
    "4.3.0" = import ./4.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "git: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "git: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
