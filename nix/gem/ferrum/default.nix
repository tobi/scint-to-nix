#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ferrum
#
# Available versions:
#   0.14
#
# Usage:
#   ferrum { version = "0.14"; }
#   ferrum { }  # latest (0.14)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.14",
  git ? { },
}:
let
  versions = {
    "0.14" = import ./0.14 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ferrum: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ferrum: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
