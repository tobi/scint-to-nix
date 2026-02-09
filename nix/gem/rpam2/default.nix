#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rpam2
#
# Available versions:
#   4.0.2
#
# Usage:
#   rpam2 { version = "4.0.2"; }
#   rpam2 { }  # latest (4.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.2",
  git ? { },
}:
let
  versions = {
    "4.0.2" = import ./4.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rpam2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rpam2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
