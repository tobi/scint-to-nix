#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ipaddress
#
# Available versions:
#   0.8.0
#   0.8.2
#   0.8.3
#
# Usage:
#   ipaddress { version = "0.8.3"; }
#   ipaddress { }  # latest (0.8.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.3",
  git ? { },
}:
let
  versions = {
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.8.2" = import ./0.8.2 { inherit lib stdenv ruby; };
    "0.8.3" = import ./0.8.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ipaddress: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ipaddress: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
