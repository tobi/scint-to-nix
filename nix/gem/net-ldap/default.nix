#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-ldap
#
# Available versions:
#   0.17.1
#   0.18.0
#   0.19.0
#   0.20.0
#
# Usage:
#   net-ldap { version = "0.20.0"; }
#   net-ldap { }  # latest (0.20.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.0",
  git ? { },
}:
let
  versions = {
    "0.17.1" = import ./0.17.1 { inherit lib stdenv ruby; };
    "0.18.0" = import ./0.18.0 { inherit lib stdenv ruby; };
    "0.19.0" = import ./0.19.0 { inherit lib stdenv ruby; };
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-ldap: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "net-ldap: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
