#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# js-routes
#
# Available versions:
#   2.2.8
#
# Usage:
#   js-routes { version = "2.2.8"; }
#   js-routes { }  # latest (2.2.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.8",
  git ? { },
}:
let
  versions = {
    "2.2.8" = import ./2.2.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "js-routes: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "js-routes: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
