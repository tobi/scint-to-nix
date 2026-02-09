#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday
#
# Available versions:
#   2.9.0
#   2.13.1
#   2.13.4
#   2.14.0
#   2.14.1
#
# Usage:
#   faraday { version = "2.14.1"; }
#   faraday { }  # latest (2.14.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.14.1",
  git ? { },
}:
let
  versions = {
    "2.9.0" = import ./2.9.0 { inherit lib stdenv ruby; };
    "2.13.1" = import ./2.13.1 { inherit lib stdenv ruby; };
    "2.13.4" = import ./2.13.4 { inherit lib stdenv ruby; };
    "2.14.0" = import ./2.14.0 { inherit lib stdenv ruby; };
    "2.14.1" = import ./2.14.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
