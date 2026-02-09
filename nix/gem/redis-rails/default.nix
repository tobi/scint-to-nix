#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-rails
#
# Available versions:
#   5.0.0
#   5.0.1
#   5.0.2
#
# Usage:
#   redis-rails { version = "5.0.2"; }
#   redis-rails { }  # latest (5.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.2",
  git ? { },
}:
let
  versions = {
    "5.0.0" = import ./5.0.0 { inherit lib stdenv ruby; };
    "5.0.1" = import ./5.0.1 { inherit lib stdenv ruby; };
    "5.0.2" = import ./5.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
