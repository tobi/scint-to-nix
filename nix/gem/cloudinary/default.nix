#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cloudinary
#
# Available versions:
#   1.29.0
#
# Usage:
#   cloudinary { version = "1.29.0"; }
#   cloudinary { }  # latest (1.29.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.29.0",
  git ? { },
}:
let
  versions = {
    "1.29.0" = import ./1.29.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cloudinary: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cloudinary: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
