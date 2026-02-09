#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# licensee
#
# Available versions:
#   9.17.0
#   9.17.1
#   9.18.0
#
# Usage:
#   licensee { version = "9.18.0"; }
#   licensee { }  # latest (9.18.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.18.0",
  git ? { },
}:
let
  versions = {
    "9.17.0" = import ./9.17.0 { inherit lib stdenv ruby; };
    "9.17.1" = import ./9.17.1 { inherit lib stdenv ruby; };
    "9.18.0" = import ./9.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "licensee: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "licensee: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
