#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-validation
#
# Available versions:
#   1.10.0
#   1.11.0
#   1.11.1
#
# Usage:
#   dry-validation { version = "1.11.1"; }
#   dry-validation { }  # latest (1.11.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.1",
  git ? { },
}:
let
  versions = {
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-validation: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "dry-validation: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
