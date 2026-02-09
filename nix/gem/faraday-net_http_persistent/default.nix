#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-net_http_persistent
#
# Available versions:
#   2.1.0
#   2.2.0
#   2.3.0
#   2.3.1
#
# Usage:
#   faraday-net_http_persistent { version = "2.3.1"; }
#   faraday-net_http_persistent { }  # latest (2.3.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.1",
  git ? { },
}:
let
  versions = {
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.3.1" = import ./2.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-net_http_persistent: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday-net_http_persistent: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
