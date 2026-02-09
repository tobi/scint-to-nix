#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth_openid_connect
#
# Available versions:
#   0.8.0
#
# Usage:
#   omniauth_openid_connect { version = "0.8.0"; }
#   omniauth_openid_connect { }  # latest (0.8.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.0",
  git ? { },
}:
let
  versions = {
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth_openid_connect: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "omniauth_openid_connect: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
