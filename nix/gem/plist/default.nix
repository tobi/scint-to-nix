#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# plist
#
# Available versions:
#   3.7.0
#   3.7.1
#   3.7.2
#
# Usage:
#   plist { version = "3.7.2"; }
#   plist { }  # latest (3.7.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.7.2",
  git ? { },
}:
let
  versions = {
    "3.7.0" = import ./3.7.0 { inherit lib stdenv ruby; };
    "3.7.1" = import ./3.7.1 { inherit lib stdenv ruby; };
    "3.7.2" = import ./3.7.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "plist: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "plist: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
