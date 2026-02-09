#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mysql2
#
# Available versions:
#   0.5.5
#   0.5.6
#   0.5.7
#
# Usage:
#   mysql2 { version = "0.5.7"; }
#   mysql2 { }  # latest (0.5.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.7",
  git ? { },
}:
let
  versions = {
    "0.5.5" = import ./0.5.5 { inherit lib stdenv ruby; };
    "0.5.6" = import ./0.5.6 { inherit lib stdenv ruby; };
    "0.5.7" = import ./0.5.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mysql2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mysql2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
