#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timecop
#
# Available versions:
#   0.9.8
#   0.9.9
#   0.9.10
#
# Usage:
#   timecop { version = "0.9.10"; }
#   timecop { }  # latest (0.9.10)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.10",
  git ? { },
}:
let
  versions = {
    "0.9.8" = import ./0.9.8 { inherit lib stdenv ruby; };
    "0.9.9" = import ./0.9.9 { inherit lib stdenv ruby; };
    "0.9.10" = import ./0.9.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "timecop: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "timecop: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
