#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-ld
#
# Available versions:
#   3.3.2
#
# Usage:
#   json-ld { version = "3.3.2"; }
#   json-ld { }  # latest (3.3.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.2",
  git ? { },
}:
let
  versions = {
    "3.3.2" = import ./3.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json-ld: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "json-ld: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
