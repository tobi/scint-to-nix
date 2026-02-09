#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rails
#
# Available versions:
#   2.24.1
#   2.30.3
#   2.32.0
#   2.33.4
#   2.34.0
#   2.34.1
#   2.34.2
#   2.34.3
#
# Usage:
#   rubocop-rails { version = "2.34.3"; }
#   rubocop-rails { }  # latest (2.34.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.34.3",
  git ? { },
}:
let
  versions = {
    "2.24.1" = import ./2.24.1 { inherit lib stdenv ruby; };
    "2.30.3" = import ./2.30.3 { inherit lib stdenv ruby; };
    "2.32.0" = import ./2.32.0 { inherit lib stdenv ruby; };
    "2.33.4" = import ./2.33.4 { inherit lib stdenv ruby; };
    "2.34.0" = import ./2.34.0 { inherit lib stdenv ruby; };
    "2.34.1" = import ./2.34.1 { inherit lib stdenv ruby; };
    "2.34.2" = import ./2.34.2 { inherit lib stdenv ruby; };
    "2.34.3" = import ./2.34.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
