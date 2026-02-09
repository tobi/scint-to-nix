#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lumberjack
#
# Available versions:
#   1.2.9
#   2.0.2
#   2.0.3
#   2.0.4
#
# Usage:
#   lumberjack { version = "2.0.4"; }
#   lumberjack { }  # latest (2.0.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.4",
  git ? { },
}:
let
  versions = {
    "1.2.9" = import ./1.2.9 { inherit lib stdenv ruby; };
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
    "2.0.3" = import ./2.0.3 { inherit lib stdenv ruby; };
    "2.0.4" = import ./2.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "lumberjack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "lumberjack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
