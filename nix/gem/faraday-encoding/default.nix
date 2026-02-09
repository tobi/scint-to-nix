#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-encoding
#
# Available versions:
#   0.0.5
#
# Usage:
#   faraday-encoding { version = "0.0.5"; }
#   faraday-encoding { }  # latest (0.0.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.5",
  git ? { },
}:
let
  versions = {
    "0.0.5" = import ./0.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-encoding: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday-encoding: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
