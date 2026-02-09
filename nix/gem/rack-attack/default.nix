#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-attack
#
# Available versions:
#   6.6.1
#   6.7.0
#   6.8.0
#
# Usage:
#   rack-attack { version = "6.8.0"; }
#   rack-attack { }  # latest (6.8.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.8.0",
  git ? { },
}:
let
  versions = {
    "6.6.1" = import ./6.6.1 { inherit lib stdenv ruby; };
    "6.7.0" = import ./6.7.0 { inherit lib stdenv ruby; };
    "6.8.0" = import ./6.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-attack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rack-attack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
