#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# has_scope
#
# Available versions:
#   0.8.1
#   0.8.2
#   0.9.0
#
# Usage:
#   has_scope { version = "0.9.0"; }
#   has_scope { }  # latest (0.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.0",
  git ? { },
}:
let
  versions = {
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
    "0.8.2" = import ./0.8.2 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "has_scope: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "has_scope: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
