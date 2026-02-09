#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stoplight
#
# Available versions:
#   5.7.0
#
# Usage:
#   stoplight { version = "5.7.0"; }
#   stoplight { }  # latest (5.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.7.0",
  git ? { },
}:
let
  versions = {
    "5.7.0" = import ./5.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stoplight: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "stoplight: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
