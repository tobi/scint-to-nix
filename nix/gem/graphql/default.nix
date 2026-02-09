#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphql
#
# Available versions:
#   2.5.17
#   2.5.18
#   2.5.19
#
# Usage:
#   graphql { version = "2.5.19"; }
#   graphql { }  # latest (2.5.19)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.19",
  git ? { },
}:
let
  versions = {
    "2.5.17" = import ./2.5.17 { inherit lib stdenv ruby; };
    "2.5.18" = import ./2.5.18 { inherit lib stdenv ruby; };
    "2.5.19" = import ./2.5.19 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "graphql: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "graphql: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
