#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsonapi-renderer
#
# Available versions:
#   0.2.0
#   0.2.1
#   0.2.2
#
# Usage:
#   jsonapi-renderer { version = "0.2.2"; }
#   jsonapi-renderer { }  # latest (0.2.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.2",
  git ? { },
}:
let
  versions = {
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
    "0.2.2" = import ./0.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jsonapi-renderer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jsonapi-renderer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
