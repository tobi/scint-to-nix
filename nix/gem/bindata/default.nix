#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bindata
#
# Available versions:
#   2.4.15
#   2.5.0
#   2.5.1
#
# Usage:
#   bindata { version = "2.5.1"; }
#   bindata { }  # latest (2.5.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.1",
  git ? { },
}:
let
  versions = {
    "2.4.15" = import ./2.4.15 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bindata: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bindata: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
