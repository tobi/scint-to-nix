#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# acts-as-taggable-on
#
# Available versions:
#   10.0.0
#   11.0.0
#   12.0.0
#   13.0.0
#
# Usage:
#   acts-as-taggable-on { version = "13.0.0"; }
#   acts-as-taggable-on { }  # latest (13.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "13.0.0",
  git ? { },
}:
let
  versions = {
    "10.0.0" = import ./10.0.0 { inherit lib stdenv ruby; };
    "11.0.0" = import ./11.0.0 { inherit lib stdenv ruby; };
    "12.0.0" = import ./12.0.0 { inherit lib stdenv ruby; };
    "13.0.0" = import ./13.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "acts-as-taggable-on: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "acts-as-taggable-on: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
