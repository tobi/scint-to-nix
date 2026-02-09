#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ahoy_matey
#
# Available versions:
#   5.0.2
#
# Usage:
#   ahoy_matey { version = "5.0.2"; }
#   ahoy_matey { }  # latest (5.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.2",
  git ? { },
}:
let
  versions = {
    "5.0.2" = import ./5.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ahoy_matey: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ahoy_matey: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
