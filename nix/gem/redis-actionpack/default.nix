#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-actionpack
#
# Available versions:
#   5.3.0
#   5.4.0
#   5.5.0
#
# Usage:
#   redis-actionpack { version = "5.5.0"; }
#   redis-actionpack { }  # latest (5.5.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.5.0",
  git ? { },
}:
let
  versions = {
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
    "5.5.0" = import ./5.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-actionpack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis-actionpack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
