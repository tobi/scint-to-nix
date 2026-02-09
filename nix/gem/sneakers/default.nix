#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sneakers
#
# Available versions:
#   2.11.0
#
# Usage:
#   sneakers { version = "2.11.0"; }
#   sneakers { }  # latest (2.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.11.0",
  git ? { },
}:
let
  versions = {
    "2.11.0" = import ./2.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sneakers: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sneakers: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
