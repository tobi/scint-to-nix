#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bunny
#
# Available versions:
#   2.22.0
#   2.23.0
#   2.24.0
#
# Usage:
#   bunny { version = "2.24.0"; }
#   bunny { }  # latest (2.24.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.24.0",
  git ? { },
}:
let
  versions = {
    "2.22.0" = import ./2.22.0 { inherit lib stdenv ruby; };
    "2.23.0" = import ./2.23.0 { inherit lib stdenv ruby; };
    "2.24.0" = import ./2.24.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bunny: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bunny: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
