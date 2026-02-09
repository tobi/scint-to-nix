#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mario-redis-lock
#
# Available versions:
#   1.2.1
#
# Usage:
#   mario-redis-lock { version = "1.2.1"; }
#   mario-redis-lock { }  # latest (1.2.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.1",
  git ? { },
}:
let
  versions = {
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mario-redis-lock: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mario-redis-lock: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
