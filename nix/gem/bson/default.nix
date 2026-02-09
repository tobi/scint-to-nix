#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bson
#
# Available versions:
#   5.1.0
#   5.1.1
#   5.2.0
#
# Usage:
#   bson { version = "5.2.0"; }
#   bson { }  # latest (5.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.0",
  git ? { },
}:
let
  versions = {
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
    "5.1.1" = import ./5.1.1 { inherit lib stdenv ruby; };
    "5.2.0" = import ./5.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bson: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bson: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
