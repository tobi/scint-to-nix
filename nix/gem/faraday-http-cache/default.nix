#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-http-cache
#
# Available versions:
#   2.5.0
#   2.5.1
#   2.6.0
#   2.6.1
#
# Usage:
#   faraday-http-cache { version = "2.6.1"; }
#   faraday-http-cache { }  # latest (2.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.1",
  git ? { },
}:
let
  versions = {
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
    "2.6.0" = import ./2.6.0 { inherit lib stdenv ruby; };
    "2.6.1" = import ./2.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-http-cache: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday-http-cache: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
