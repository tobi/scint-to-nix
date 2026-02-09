#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-spinner
#
# Available versions:
#   0.9.1
#   0.9.2
#   0.9.3
#
# Usage:
#   tty-spinner { version = "0.9.3"; }
#   tty-spinner { }  # latest (0.9.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.3",
  git ? { },
}:
let
  versions = {
    "0.9.1" = import ./0.9.1 { inherit lib stdenv ruby; };
    "0.9.2" = import ./0.9.2 { inherit lib stdenv ruby; };
    "0.9.3" = import ./0.9.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-spinner: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tty-spinner: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
