#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-types
#
# Available versions:
#   1.8.3
#   1.9.0
#   1.9.1
#
# Usage:
#   dry-types { version = "1.9.1"; }
#   dry-types { }  # latest (1.9.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.1",
  git ? { },
}:
let
  versions = {
    "1.8.3" = import ./1.8.3 { inherit lib stdenv ruby; };
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
    "1.9.1" = import ./1.9.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-types: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "dry-types: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
