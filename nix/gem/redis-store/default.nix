#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-store
#
# Available versions:
#   1.9.2
#   1.10.0
#   1.11.0
#
# Usage:
#   redis-store { version = "1.11.0"; }
#   redis-store { }  # latest (1.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.0",
  git ? { },
}:
let
  versions = {
    "1.9.2" = import ./1.9.2 { inherit lib stdenv ruby; };
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-store: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis-store: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
