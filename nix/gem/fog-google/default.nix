#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-google
#
# Available versions:
#   1.29.1
#   1.29.2
#   1.29.3
#
# Usage:
#   fog-google { version = "1.29.3"; }
#   fog-google { }  # latest (1.29.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.29.3",
  git ? { },
}:
let
  versions = {
    "1.29.1" = import ./1.29.1 { inherit lib stdenv ruby; };
    "1.29.2" = import ./1.29.2 { inherit lib stdenv ruby; };
    "1.29.3" = import ./1.29.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-google: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fog-google: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
