#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# case_transform
#
# Available versions:
#   0.1
#   0.2
#
# Usage:
#   case_transform { version = "0.2"; }
#   case_transform { }  # latest (0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2",
  git ? { },
}:
let
  versions = {
    "0.1" = import ./0.1 { inherit lib stdenv ruby; };
    "0.2" = import ./0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "case_transform: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "case_transform: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
