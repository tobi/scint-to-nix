#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ethon
#
# Available versions:
#   0.16.0
#   0.17.0
#   0.18.0
#
# Usage:
#   ethon { version = "0.18.0"; }
#   ethon { }  # latest (0.18.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.0",
  git ? { },
}:
let
  versions = {
    "0.16.0" = import ./0.16.0 { inherit lib stdenv ruby; };
    "0.17.0" = import ./0.17.0 { inherit lib stdenv ruby; };
    "0.18.0" = import ./0.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ethon: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ethon: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
