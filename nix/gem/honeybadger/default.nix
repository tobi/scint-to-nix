#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# honeybadger
#
# Available versions:
#   4.12.2
#
# Usage:
#   honeybadger { version = "4.12.2"; }
#   honeybadger { }  # latest (4.12.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.12.2",
  git ? { },
}:
let
  versions = {
    "4.12.2" = import ./4.12.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "honeybadger: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "honeybadger: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
