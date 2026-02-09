#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# multi_json
#
# Available versions:
#   1.15.0
#   1.18.0
#   1.19.0
#   1.19.1
#
# Usage:
#   multi_json { version = "1.19.1"; }
#   multi_json { }  # latest (1.19.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.19.1",
  git ? { },
}:
let
  versions = {
    "1.15.0" = import ./1.15.0 { inherit lib stdenv ruby; };
    "1.18.0" = import ./1.18.0 { inherit lib stdenv ruby; };
    "1.19.0" = import ./1.19.0 { inherit lib stdenv ruby; };
    "1.19.1" = import ./1.19.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "multi_json: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "multi_json: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
