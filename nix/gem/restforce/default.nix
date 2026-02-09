#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# restforce
#
# Available versions:
#   7.6.0
#   8.0.0
#   8.0.1
#
# Usage:
#   restforce { version = "8.0.1"; }
#   restforce { }  # latest (8.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.1",
  git ? { },
}:
let
  versions = {
    "7.6.0" = import ./7.6.0 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "8.0.1" = import ./8.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "restforce: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "restforce: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
