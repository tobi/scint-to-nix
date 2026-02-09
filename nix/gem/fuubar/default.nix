#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuubar
#
# Available versions:
#   2.4.1
#   2.5.0
#   2.5.1
#
# Usage:
#   fuubar { version = "2.5.1"; }
#   fuubar { }  # latest (2.5.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.1",
  git ? { },
}:
let
  versions = {
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fuubar: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fuubar: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
