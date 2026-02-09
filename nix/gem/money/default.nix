#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# money
#
# Available versions:
#   6.19.0
#   7.0.0
#   7.0.1
#   7.0.2
#
# Usage:
#   money { version = "7.0.2"; }
#   money { }  # latest (7.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.2",
  git ? { },
}:
let
  versions = {
    "6.19.0" = import ./6.19.0 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
    "7.0.2" = import ./7.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "money: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "money: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
