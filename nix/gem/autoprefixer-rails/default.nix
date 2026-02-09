#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# autoprefixer-rails
#
# Available versions:
#   10.4.16.0
#   10.4.19.0
#   10.4.21.0
#
# Usage:
#   autoprefixer-rails { version = "10.4.21.0"; }
#   autoprefixer-rails { }  # latest (10.4.21.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "10.4.21.0",
  git ? { },
}:
let
  versions = {
    "10.4.16.0" = import ./10.4.16.0 { inherit lib stdenv ruby; };
    "10.4.19.0" = import ./10.4.19.0 { inherit lib stdenv ruby; };
    "10.4.21.0" = import ./10.4.21.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "autoprefixer-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "autoprefixer-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
