#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httpclient
#
# Available versions:
#   2.8.2.4
#   2.8.3
#   2.9.0
#
# Usage:
#   httpclient { version = "2.9.0"; }
#   httpclient { }  # latest (2.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.9.0",
  git ? { },
}:
let
  versions = {
    "2.8.2.4" = import ./2.8.2.4 { inherit lib stdenv ruby; };
    "2.8.3" = import ./2.8.3 { inherit lib stdenv ruby; };
    "2.9.0" = import ./2.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "httpclient: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "httpclient: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
