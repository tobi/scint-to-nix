#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sprockets
#
# Available versions:
#   4.1.1
#   4.2.0
#   4.2.1
#   4.2.2
#
# Usage:
#   sprockets { version = "4.2.2"; }
#   sprockets { }  # latest (4.2.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.2",
  git ? { },
}:
let
  versions = {
    "4.1.1" = import ./4.1.1 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
    "4.2.1" = import ./4.2.1 { inherit lib stdenv ruby; };
    "4.2.2" = import ./4.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sprockets: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sprockets: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
