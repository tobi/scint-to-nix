#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# resque-scheduler
#
# Available versions:
#   4.11.0
#
# Usage:
#   resque-scheduler { version = "4.11.0"; }
#   resque-scheduler { }  # latest (4.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.11.0",
  git ? { },
}:
let
  versions = {
    "4.11.0" = import ./4.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "resque-scheduler: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "resque-scheduler: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
