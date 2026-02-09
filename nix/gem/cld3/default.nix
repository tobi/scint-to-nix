#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cld3
#
# Available versions:
#   3.6.0
#
# Usage:
#   cld3 { version = "3.6.0"; }
#   cld3 { }  # latest (3.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.6.0",
  git ? { },
}:
let
  versions = {
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cld3: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cld3: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
