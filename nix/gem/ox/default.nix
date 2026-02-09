#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ox
#
# Available versions:
#   2.14.23
#
# Usage:
#   ox { version = "2.14.23"; }
#   ox { }  # latest (2.14.23)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.14.23",
  git ? { },
}:
let
  versions = {
    "2.14.23" = import ./2.14.23 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ox: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ox: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
