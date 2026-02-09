#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# docile
#
# Available versions:
#   1.3.5
#   1.4.0
#   1.4.1
#
# Usage:
#   docile { version = "1.4.1"; }
#   docile { }  # latest (1.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.1",
  git ? { },
}:
let
  versions = {
    "1.3.5" = import ./1.3.5 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
    "1.4.1" = import ./1.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "docile: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "docile: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
