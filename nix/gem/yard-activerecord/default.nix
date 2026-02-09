#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yard-activerecord
#
# Available versions:
#   0.0.16
#
# Usage:
#   yard-activerecord { version = "0.0.16"; }
#   yard-activerecord { }  # latest (0.0.16)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.16",
  git ? { },
}:
let
  versions = {
    "0.0.16" = import ./0.0.16 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "yard-activerecord: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "yard-activerecord: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
