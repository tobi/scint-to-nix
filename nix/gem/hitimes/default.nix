#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hitimes
#
# Available versions:
#   2.0.0
#   3.0.0
#   3.1.0
#
# Usage:
#   hitimes { version = "3.1.0"; }
#   hitimes { }  # latest (3.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.0",
  git ? { },
}:
let
  versions = {
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hitimes: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "hitimes: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
