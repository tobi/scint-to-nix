#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# prometheus-client
#
# Available versions:
#   4.2.3
#   4.2.4
#   4.2.5
#
# Usage:
#   prometheus-client { version = "4.2.5"; }
#   prometheus-client { }  # latest (4.2.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.5",
  git ? { },
}:
let
  versions = {
    "4.2.3" = import ./4.2.3 { inherit lib stdenv ruby; };
    "4.2.4" = import ./4.2.4 { inherit lib stdenv ruby; };
    "4.2.5" = import ./4.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "prometheus-client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "prometheus-client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
