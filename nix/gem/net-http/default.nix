#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http
#
# Available versions:
#   0.4.1
#   0.6.0
#   0.8.0
#   0.9.0
#   0.9.1
#
# Usage:
#   net-http { version = "0.9.1"; }
#   net-http { }  # latest (0.9.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.1",
  git ? { },
}:
let
  versions = {
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.9.1" = import ./0.9.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-http: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "net-http: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
