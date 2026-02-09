#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-schema
#
# Available versions:
#   1.14.0
#   1.14.1
#   1.15.0
#
# Usage:
#   dry-schema { version = "1.15.0"; }
#   dry-schema { }  # latest (1.15.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.15.0",
  git ? { },
}:
let
  versions = {
    "1.14.0" = import ./1.14.0 { inherit lib stdenv ruby; };
    "1.14.1" = import ./1.14.1 { inherit lib stdenv ruby; };
    "1.15.0" = import ./1.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-schema: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "dry-schema: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
