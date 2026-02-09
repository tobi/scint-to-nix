#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-activesupport
#
# Available versions:
#   5.2.0
#   5.2.1
#   5.3.0
#
# Usage:
#   redis-activesupport { version = "5.3.0"; }
#   redis-activesupport { }  # latest (5.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.3.0",
  git ? { },
}:
let
  versions = {
    "5.2.0" = import ./5.2.0 { inherit lib stdenv ruby; };
    "5.2.1" = import ./5.2.1 { inherit lib stdenv ruby; };
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-activesupport: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis-activesupport: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
