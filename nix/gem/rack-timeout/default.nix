#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-timeout
#
# Available versions:
#   0.6.2
#   0.6.3
#   0.7.0
#
# Usage:
#   rack-timeout { version = "0.7.0"; }
#   rack-timeout { }  # latest (0.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.0",
  git ? { },
}:
let
  versions = {
    "0.6.2" = import ./0.6.2 { inherit lib stdenv ruby; };
    "0.6.3" = import ./0.6.3 { inherit lib stdenv ruby; };
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-timeout: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rack-timeout: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
