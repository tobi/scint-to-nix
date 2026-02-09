#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# html-pipeline
#
# Available versions:
#   3.2.2
#   3.2.3
#   3.2.4
#
# Usage:
#   html-pipeline { version = "3.2.4"; }
#   html-pipeline { }  # latest (3.2.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.4",
  git ? { },
}:
let
  versions = {
    "3.2.2" = import ./3.2.2 { inherit lib stdenv ruby; };
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
    "3.2.4" = import ./3.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "html-pipeline: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "html-pipeline: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
