#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rpush
#
# Available versions:
#   7.0.1
#
# Usage:
#   rpush { version = "7.0.1"; }
#   rpush { }  # latest (7.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.1",
  git ? { },
}:
let
  versions = {
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rpush: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rpush: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
