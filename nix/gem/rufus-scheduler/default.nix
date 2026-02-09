#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rufus-scheduler
#
# Available versions:
#   3.9.0
#   3.9.1
#   3.9.2
#
# Usage:
#   rufus-scheduler { version = "3.9.2"; }
#   rufus-scheduler { }  # latest (3.9.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.2",
  git ? { },
}:
let
  versions = {
    "3.9.0" = import ./3.9.0 { inherit lib stdenv ruby; };
    "3.9.1" = import ./3.9.1 { inherit lib stdenv ruby; };
    "3.9.2" = import ./3.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rufus-scheduler: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rufus-scheduler: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
