#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# doorkeeper
#
# Available versions:
#   5.8.0
#   5.8.1
#   5.8.2
#
# Usage:
#   doorkeeper { version = "5.8.2"; }
#   doorkeeper { }  # latest (5.8.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.8.2",
  git ? { },
}:
let
  versions = {
    "5.8.0" = import ./5.8.0 { inherit lib stdenv ruby; };
    "5.8.1" = import ./5.8.1 { inherit lib stdenv ruby; };
    "5.8.2" = import ./5.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "doorkeeper: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "doorkeeper: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
