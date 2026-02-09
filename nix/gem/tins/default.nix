#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tins
#
# Available versions:
#   1.50.0
#   1.51.0
#   1.51.1
#
# Usage:
#   tins { version = "1.51.1"; }
#   tins { }  # latest (1.51.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.51.1",
  git ? { },
}:
let
  versions = {
    "1.50.0" = import ./1.50.0 { inherit lib stdenv ruby; };
    "1.51.0" = import ./1.51.0 { inherit lib stdenv ruby; };
    "1.51.1" = import ./1.51.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tins: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tins: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
