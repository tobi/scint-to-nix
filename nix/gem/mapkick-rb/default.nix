#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mapkick-rb
#
# Available versions:
#   0.2.0
#
# Usage:
#   mapkick-rb { version = "0.2.0"; }
#   mapkick-rb { }  # latest (0.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.0",
  git ? { },
}:
let
  versions = {
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mapkick-rb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mapkick-rb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
