#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mongo
#
# Available versions:
#   2.21.3
#   2.22.0
#   2.23.0
#
# Usage:
#   mongo { version = "2.23.0"; }
#   mongo { }  # latest (2.23.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.23.0",
  git ? { },
}:
let
  versions = {
    "2.21.3" = import ./2.21.3 { inherit lib stdenv ruby; };
    "2.22.0" = import ./2.22.0 { inherit lib stdenv ruby; };
    "2.23.0" = import ./2.23.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mongo: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mongo: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
