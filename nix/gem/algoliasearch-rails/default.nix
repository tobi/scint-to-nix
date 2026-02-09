#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algoliasearch-rails
#
# Available versions:
#   2.3.2
#
# Usage:
#   algoliasearch-rails { version = "2.3.2"; }
#   algoliasearch-rails { }  # latest (2.3.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.2",
  git ? { },
}:
let
  versions = {
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "algoliasearch-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "algoliasearch-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
