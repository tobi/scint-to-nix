#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# blurhash
#
# Available versions:
#   0.1.8
#
# Usage:
#   blurhash { version = "0.1.8"; }
#   blurhash { }  # latest (0.1.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.8",
  git ? { },
}:
let
  versions = {
    "0.1.8" = import ./0.1.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "blurhash: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "blurhash: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
