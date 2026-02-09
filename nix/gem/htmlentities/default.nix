#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# htmlentities
#
# Available versions:
#   4.3.4
#   4.4.0
#   4.4.1
#   4.4.2
#
# Usage:
#   htmlentities { version = "4.4.2"; }
#   htmlentities { }  # latest (4.4.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.2",
  git ? { },
}:
let
  versions = {
    "4.3.4" = import ./4.3.4 { inherit lib stdenv ruby; };
    "4.4.0" = import ./4.4.0 { inherit lib stdenv ruby; };
    "4.4.1" = import ./4.4.1 { inherit lib stdenv ruby; };
    "4.4.2" = import ./4.4.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "htmlentities: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "htmlentities: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
