#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-command
#
# Available versions:
#   0.9.0
#   0.10.0
#   0.10.1
#
# Usage:
#   tty-command { version = "0.10.1"; }
#   tty-command { }  # latest (0.10.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.1",
  git ? { },
}:
let
  versions = {
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
    "0.10.1" = import ./0.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-command: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tty-command: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
