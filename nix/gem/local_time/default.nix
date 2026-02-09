#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# local_time
#
# Available versions:
#   3.0.3
#
# Usage:
#   local_time { version = "3.0.3"; }
#   local_time { }  # latest (3.0.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.3",
  git ? { },
}:
let
  versions = {
    "3.0.3" = import ./3.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "local_time: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "local_time: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
