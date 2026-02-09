#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphiql-rails
#
# Available versions:
#   1.10.3
#   1.10.4
#   1.10.5
#
# Usage:
#   graphiql-rails { version = "1.10.5"; }
#   graphiql-rails { }  # latest (1.10.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.10.5",
  git ? { },
}:
let
  versions = {
    "1.10.3" = import ./1.10.3 { inherit lib stdenv ruby; };
    "1.10.4" = import ./1.10.4 { inherit lib stdenv ruby; };
    "1.10.5" = import ./1.10.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "graphiql-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "graphiql-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
