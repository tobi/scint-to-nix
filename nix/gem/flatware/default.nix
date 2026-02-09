#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flatware
#
# Available versions:
#   2.3.4
#
# Usage:
#   flatware { version = "2.3.4"; }
#   flatware { }  # latest (2.3.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.4",
  git ? { },
}:
let
  versions = {
    "2.3.4" = import ./2.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flatware: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "flatware: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
