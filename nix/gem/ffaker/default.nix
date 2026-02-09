#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffaker
#
# Available versions:
#   2.23.0
#   2.24.0
#   2.25.0
#
# Usage:
#   ffaker { version = "2.25.0"; }
#   ffaker { }  # latest (2.25.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.25.0",
  git ? { },
}:
let
  versions = {
    "2.23.0" = import ./2.23.0 { inherit lib stdenv ruby; };
    "2.24.0" = import ./2.24.0 { inherit lib stdenv ruby; };
    "2.25.0" = import ./2.25.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ffaker: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ffaker: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
