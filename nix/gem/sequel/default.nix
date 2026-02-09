#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sequel
#
# Available versions:
#   5.99.0
#   5.100.0
#   5.101.0
#
# Usage:
#   sequel { version = "5.101.0"; }
#   sequel { }  # latest (5.101.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.101.0",
  git ? { },
}:
let
  versions = {
    "5.99.0" = import ./5.99.0 { inherit lib stdenv ruby; };
    "5.100.0" = import ./5.100.0 { inherit lib stdenv ruby; };
    "5.101.0" = import ./5.101.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sequel: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sequel: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
