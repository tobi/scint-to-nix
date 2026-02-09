#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# racc
#
# Available versions:
#   1.7.3
#   1.8.0
#   1.8.1
#
# Usage:
#   racc { version = "1.8.1"; }
#   racc { }  # latest (1.8.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.1",
  git ? { },
}:
let
  versions = {
    "1.7.3" = import ./1.7.3 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.8.1" = import ./1.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "racc: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "racc: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
