#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json_pure
#
# Available versions:
#   2.7.6
#   2.8.0
#   2.8.1
#
# Usage:
#   json_pure { version = "2.8.1"; }
#   json_pure { }  # latest (2.8.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.1",
  git ? { },
}:
let
  versions = {
    "2.7.6" = import ./2.7.6 { inherit lib stdenv ruby; };
    "2.8.0" = import ./2.8.0 { inherit lib stdenv ruby; };
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json_pure: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "json_pure: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
