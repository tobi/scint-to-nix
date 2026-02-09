#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thin
#
# Available versions:
#   1.8.2
#   2.0.0
#   2.0.1
#
# Usage:
#   thin { version = "2.0.1"; }
#   thin { }  # latest (2.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.1",
  git ? { },
}:
let
  versions = {
    "1.8.2" = import ./1.8.2 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.0.1" = import ./2.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "thin: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "thin: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
