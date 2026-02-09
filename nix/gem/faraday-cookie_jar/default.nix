#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-cookie_jar
#
# Available versions:
#   0.0.6
#   0.0.7
#   0.0.8
#
# Usage:
#   faraday-cookie_jar { version = "0.0.8"; }
#   faraday-cookie_jar { }  # latest (0.0.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.8",
  git ? { },
}:
let
  versions = {
    "0.0.6" = import ./0.0.6 { inherit lib stdenv ruby; };
    "0.0.7" = import ./0.0.7 { inherit lib stdenv ruby; };
    "0.0.8" = import ./0.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-cookie_jar: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday-cookie_jar: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
