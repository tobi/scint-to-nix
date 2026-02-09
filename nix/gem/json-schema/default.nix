#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-schema
#
# Available versions:
#   2.8.1
#   5.2.2
#   6.0.0
#   6.1.0
#
# Usage:
#   json-schema { version = "6.1.0"; }
#   json-schema { }  # latest (6.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.1.0",
  git ? { },
}:
let
  versions = {
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "5.2.2" = import ./5.2.2 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json-schema: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "json-schema: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
