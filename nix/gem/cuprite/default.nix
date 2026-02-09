#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cuprite
#
# Available versions:
#   0.15
#
# Usage:
#   cuprite { version = "0.15"; }
#   cuprite { }  # latest (0.15)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15",
  git ? { },
}:
let
  versions = {
    "0.15" = import ./0.15 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cuprite: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cuprite: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
