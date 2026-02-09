#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# with_model
#
# Available versions:
#   2.1.7
#
# Usage:
#   with_model { version = "2.1.7"; }
#   with_model { }  # latest (2.1.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.7",
  git ? { },
}:
let
  versions = {
    "2.1.7" = import ./2.1.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "with_model: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "with_model: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
