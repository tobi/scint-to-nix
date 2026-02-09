#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# alba
#
# Available versions:
#   3.10.0
#
# Usage:
#   alba { version = "3.10.0"; }
#   alba { }  # latest (3.10.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.10.0",
  git ? { },
}:
let
  versions = {
    "3.10.0" = import ./3.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "alba: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "alba: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
