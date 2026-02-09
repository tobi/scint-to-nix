#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# amazing_print
#
# Available versions:
#   1.6.0
#
# Usage:
#   amazing_print { version = "1.6.0"; }
#   amazing_print { }  # latest (1.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.0",
  git ? { },
}:
let
  versions = {
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "amazing_print: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "amazing_print: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
