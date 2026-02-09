#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest-mock
#
# Available versions:
#   5.27.0
#
# Usage:
#   minitest-mock { version = "5.27.0"; }
#   minitest-mock { }  # latest (5.27.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.27.0",
  git ? { },
}:
let
  versions = {
    "5.27.0" = import ./5.27.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "minitest-mock: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "minitest-mock: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
