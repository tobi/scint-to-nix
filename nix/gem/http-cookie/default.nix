#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-cookie
#
# Available versions:
#   1.0.5
#   1.0.7
#   1.0.8
#   1.1.0
#
# Usage:
#   http-cookie { version = "1.1.0"; }
#   http-cookie { }  # latest (1.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.0",
  git ? { },
}:
let
  versions = {
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "1.0.7" = import ./1.0.7 { inherit lib stdenv ruby; };
    "1.0.8" = import ./1.0.8 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http-cookie: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "http-cookie: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
