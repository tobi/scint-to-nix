#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pdf-core
#
# Available versions:
#   0.8.1
#   0.9.0
#   0.10.0
#
# Usage:
#   pdf-core { version = "0.10.0"; }
#   pdf-core { }  # latest (0.10.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.0",
  git ? { },
}:
let
  versions = {
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pdf-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pdf-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
