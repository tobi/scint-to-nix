#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-rack
#
# Available versions:
#   2.0.0
#   2.1.2
#   2.1.3
#
# Usage:
#   faraday-rack { version = "2.1.3"; }
#   faraday-rack { }  # latest (2.1.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.3",
  git ? { },
}:
let
  versions = {
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "2.1.3" = import ./2.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-rack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday-rack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
