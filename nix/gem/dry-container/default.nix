#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-container
#
# Available versions:
#   0.10.0
#   0.10.1
#   0.11.0
#
# Usage:
#   dry-container { version = "0.11.0"; }
#   dry-container { }  # latest (0.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.0",
  git ? { },
}:
let
  versions = {
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
    "0.10.1" = import ./0.10.1 { inherit lib stdenv ruby; };
    "0.11.0" = import ./0.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-container: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "dry-container: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
