#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solidus_support
#
# Available versions:
#   0.15.0
#
# Usage:
#   solidus_support { version = "0.15.0"; }
#   solidus_support { }  # latest (0.15.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.0",
  git ? { },
}:
let
  versions = {
    "0.15.0" = import ./0.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solidus_support: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "solidus_support: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
