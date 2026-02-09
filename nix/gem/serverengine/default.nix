#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# serverengine
#
# Available versions:
#   2.0.7
#
# Usage:
#   serverengine { version = "2.0.7"; }
#   serverengine { }  # latest (2.0.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.7",
  git ? { },
}:
let
  versions = {
    "2.0.7" = import ./2.0.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "serverengine: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "serverengine: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
