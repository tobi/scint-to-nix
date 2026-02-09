#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# specinfra
#
# Available versions:
#   2.93.0
#   2.94.0
#   2.94.1
#
# Usage:
#   specinfra { version = "2.94.1"; }
#   specinfra { }  # latest (2.94.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.94.1",
  git ? { },
}:
let
  versions = {
    "2.93.0" = import ./2.93.0 { inherit lib stdenv ruby; };
    "2.94.0" = import ./2.94.0 { inherit lib stdenv ruby; };
    "2.94.1" = import ./2.94.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "specinfra: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "specinfra: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
