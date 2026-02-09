#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbo-rails
#
# Available versions:
#   2.0.11
#   2.0.21
#   2.0.22
#   2.0.23
#
# Usage:
#   turbo-rails { version = "2.0.23"; }
#   turbo-rails { }  # latest (2.0.23)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.23",
  git ? { },
}:
let
  versions = {
    "2.0.11" = import ./2.0.11 { inherit lib stdenv ruby; };
    "2.0.21" = import ./2.0.21 { inherit lib stdenv ruby; };
    "2.0.22" = import ./2.0.22 { inherit lib stdenv ruby; };
    "2.0.23" = import ./2.0.23 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "turbo-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "turbo-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
