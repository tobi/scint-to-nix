#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# db-query-matchers
#
# Available versions:
#   0.15.0
#
# Usage:
#   db-query-matchers { version = "0.15.0"; }
#   db-query-matchers { }  # latest (0.15.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.0",
  git ? { },
}:
let
  versions = {
    "0.15.0" = import ./0.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "db-query-matchers: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "db-query-matchers: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
