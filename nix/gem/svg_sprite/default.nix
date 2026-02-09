#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# svg_sprite
#
# Available versions:
#   1.0.3
#
# Usage:
#   svg_sprite { version = "1.0.3"; }
#   svg_sprite { }  # latest (1.0.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.3",
  git ? { },
}:
let
  versions = {
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "svg_sprite: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "svg_sprite: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
