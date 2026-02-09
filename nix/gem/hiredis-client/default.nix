#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hiredis-client
#
# Available versions:
#   0.26.4
#
# Usage:
#   hiredis-client { version = "0.26.4"; }
#   hiredis-client { }  # latest (0.26.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.4",
  git ? { },
}:
let
  versions = {
    "0.26.4" = import ./0.26.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hiredis-client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "hiredis-client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
