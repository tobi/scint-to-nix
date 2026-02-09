#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erubis
#
# Available versions:
#   2.6.5
#   2.7.0
#
# Usage:
#   erubis { version = "2.7.0"; }
#   erubis { }  # latest (2.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.0",
  git ? { },
}:
let
  versions = {
    "2.6.5" = import ./2.6.5 { inherit lib stdenv ruby; };
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "erubis: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "erubis: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
