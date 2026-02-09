#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cucumber
#
# Available versions:
#   10.1.0
#   10.1.1
#   10.2.0
#
# Usage:
#   cucumber { version = "10.2.0"; }
#   cucumber { }  # latest (10.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "10.2.0",
  git ? { },
}:
let
  versions = {
    "10.1.0" = import ./10.1.0 { inherit lib stdenv ruby; };
    "10.1.1" = import ./10.1.1 { inherit lib stdenv ruby; };
    "10.2.0" = import ./10.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cucumber: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cucumber: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
