#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# terminal-table
#
# Available versions:
#   3.0.1
#   3.0.2
#   4.0.0
#
# Usage:
#   terminal-table { version = "4.0.0"; }
#   terminal-table { }  # latest (4.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0",
  git ? { },
}:
let
  versions = {
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "3.0.2" = import ./3.0.2 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "terminal-table: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "terminal-table: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
