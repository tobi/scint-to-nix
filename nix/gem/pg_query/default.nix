#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg_query
#
# Available versions:
#   4.2.3
#   6.1.0
#   6.2.1
#   6.2.2
#
# Usage:
#   pg_query { version = "6.2.2"; }
#   pg_query { }  # latest (6.2.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.2.2",
  git ? { },
}:
let
  versions = {
    "4.2.3" = import ./4.2.3 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
    "6.2.1" = import ./6.2.1 { inherit lib stdenv ruby; };
    "6.2.2" = import ./6.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pg_query: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pg_query: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
