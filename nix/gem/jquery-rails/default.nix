#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-rails
#
# Available versions:
#   4.5.1
#   4.6.0
#   4.6.1
#
# Usage:
#   jquery-rails { version = "4.6.1"; }
#   jquery-rails { }  # latest (4.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.6.1",
  git ? { },
}:
let
  versions = {
    "4.5.1" = import ./4.5.1 { inherit lib stdenv ruby; };
    "4.6.0" = import ./4.6.0 { inherit lib stdenv ruby; };
    "4.6.1" = import ./4.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jquery-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jquery-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
