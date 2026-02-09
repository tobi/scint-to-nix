#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# carrierwave
#
# Available versions:
#   2.2.6
#   3.1.0
#   3.1.1
#   3.1.2
#
# Usage:
#   carrierwave { version = "3.1.2"; }
#   carrierwave { }  # latest (3.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.2",
  git ? { },
}:
let
  versions = {
    "2.2.6" = import ./2.2.6 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.1.1" = import ./3.1.1 { inherit lib stdenv ruby; };
    "3.1.2" = import ./3.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "carrierwave: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "carrierwave: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
