#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbs
#
# Available versions:
#   2.8.4
#   3.9.5
#   4.0.0.dev.5
#
# Usage:
#   rbs { version = "4.0.0.dev.5"; }
#   rbs { }  # latest (4.0.0.dev.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0.dev.5",
  git ? { },
}:
let
  versions = {
    "2.8.4" = import ./2.8.4 { inherit lib stdenv ruby; };
    "3.9.5" = import ./3.9.5 { inherit lib stdenv ruby; };
    "4.0.0.dev.5" = import ./4.0.0.dev.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbs: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rbs: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
