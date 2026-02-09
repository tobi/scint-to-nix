#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-facebook
#
# Available versions:
#   8.0.0
#   9.0.0
#   10.0.0
#
# Usage:
#   omniauth-facebook { version = "10.0.0"; }
#   omniauth-facebook { }  # latest (10.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "10.0.0",
  git ? { },
}:
let
  versions = {
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "9.0.0" = import ./9.0.0 { inherit lib stdenv ruby; };
    "10.0.0" = import ./10.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth-facebook: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "omniauth-facebook: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
