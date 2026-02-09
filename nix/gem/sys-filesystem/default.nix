#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sys-filesystem
#
# Available versions:
#   1.5.3
#   1.5.4
#   1.5.5
#
# Usage:
#   sys-filesystem { version = "1.5.5"; }
#   sys-filesystem { }  # latest (1.5.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.5.5",
  git ? { },
}:
let
  versions = {
    "1.5.3" = import ./1.5.3 { inherit lib stdenv ruby; };
    "1.5.4" = import ./1.5.4 { inherit lib stdenv ruby; };
    "1.5.5" = import ./1.5.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sys-filesystem: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sys-filesystem: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
