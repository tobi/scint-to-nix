#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# starry
#
# Available versions:
#   0.2.0
#
# Usage:
#   starry { version = "0.2.0"; }
#   starry { }  # latest (0.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.0",
  git ? { },
}:
let
  versions = {
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "starry: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "starry: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
