#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sdoc
#
# Available versions:
#   2.6.3
#   2.6.4
#   2.6.5
#
# Usage:
#   sdoc { version = "2.6.5"; }
#   sdoc { }  # latest (2.6.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.5",
  git ? { },
}:
let
  versions = {
    "2.6.3" = import ./2.6.3 { inherit lib stdenv ruby; };
    "2.6.4" = import ./2.6.4 { inherit lib stdenv ruby; };
    "2.6.5" = import ./2.6.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sdoc: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sdoc: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
