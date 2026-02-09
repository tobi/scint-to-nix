#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# requestjs-rails
#
# Available versions:
#   0.0.14
#
# Usage:
#   requestjs-rails { version = "0.0.14"; }
#   requestjs-rails { }  # latest (0.0.14)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.14",
  git ? { },
}:
let
  versions = {
    "0.0.14" = import ./0.0.14 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "requestjs-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "requestjs-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
