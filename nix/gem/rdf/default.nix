#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdf
#
# Available versions:
#   3.3.4
#
# Usage:
#   rdf { version = "3.3.4"; }
#   rdf { }  # latest (3.3.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.4",
  git ? { },
}:
let
  versions = {
    "3.3.4" = import ./3.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rdf: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rdf: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
