#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# seed-fu
#
# Available versions:
#   2.3.6
#   2.3.7
#   2.3.9
#
# Usage:
#   seed-fu { version = "2.3.9"; }
#   seed-fu { }  # latest (2.3.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.9",
  git ? { },
}:
let
  versions = {
    "2.3.6" = import ./2.3.6 { inherit lib stdenv ruby; };
    "2.3.7" = import ./2.3.7 { inherit lib stdenv ruby; };
    "2.3.9" = import ./2.3.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "seed-fu: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "seed-fu: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
