#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# colored
#
# Available versions:
#   1.2
#
# Usage:
#   colored { version = "1.2"; }
#   colored { }  # latest (1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2",
  git ? { },
}:
let
  versions = {
    "1.2" = import ./1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "colored: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "colored: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
