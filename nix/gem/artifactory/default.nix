#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# artifactory
#
# Available versions:
#   3.0.13
#   3.0.15
#   3.0.17
#
# Usage:
#   artifactory { version = "3.0.17"; }
#   artifactory { }  # latest (3.0.17)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.17",
  git ? { },
}:
let
  versions = {
    "3.0.13" = import ./3.0.13 { inherit lib stdenv ruby; };
    "3.0.15" = import ./3.0.15 { inherit lib stdenv ruby; };
    "3.0.17" = import ./3.0.17 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "artifactory: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "artifactory: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
