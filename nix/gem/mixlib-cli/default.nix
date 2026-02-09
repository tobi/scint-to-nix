#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-cli
#
# Available versions:
#   2.1.5
#   2.1.6
#   2.1.8
#
# Usage:
#   mixlib-cli { version = "2.1.8"; }
#   mixlib-cli { }  # latest (2.1.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.8",
  git ? { },
}:
let
  versions = {
    "2.1.5" = import ./2.1.5 { inherit lib stdenv ruby; };
    "2.1.6" = import ./2.1.6 { inherit lib stdenv ruby; };
    "2.1.8" = import ./2.1.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mixlib-cli: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mixlib-cli: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
