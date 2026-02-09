#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wannabe_bool
#
# Available versions:
#   0.7.1
#
# Usage:
#   wannabe_bool { version = "0.7.1"; }
#   wannabe_bool { }  # latest (0.7.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.1",
  git ? { },
}:
let
  versions = {
    "0.7.1" = import ./0.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wannabe_bool: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "wannabe_bool: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
