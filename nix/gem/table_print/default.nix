#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# table_print
#
# Available versions:
#   1.5.5
#   1.5.6
#   1.5.7
#
# Usage:
#   table_print { version = "1.5.7"; }
#   table_print { }  # latest (1.5.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.5.7",
  git ? { },
}:
let
  versions = {
    "1.5.5" = import ./1.5.5 { inherit lib stdenv ruby; };
    "1.5.6" = import ./1.5.6 { inherit lib stdenv ruby; };
    "1.5.7" = import ./1.5.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "table_print: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "table_print: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
