#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# color_diff
#
# Available versions:
#   0.2
#
# Usage:
#   color_diff { version = "0.2"; }
#   color_diff { }  # latest (0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2",
  git ? { },
}:
let
  versions = {
    "0.2" = import ./0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "color_diff: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "color_diff: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
