#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wasabi
#
# Available versions:
#   5.0.2
#   5.0.3
#   5.1.0
#
# Usage:
#   wasabi { version = "5.1.0"; }
#   wasabi { }  # latest (5.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.1.0",
  git ? { },
}:
let
  versions = {
    "5.0.2" = import ./5.0.2 { inherit lib stdenv ruby; };
    "5.0.3" = import ./5.0.3 { inherit lib stdenv ruby; };
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wasabi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "wasabi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
