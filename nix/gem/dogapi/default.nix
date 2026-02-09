#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dogapi
#
# Available versions:
#   1.43.0
#   1.44.0
#   1.45.0
#
# Usage:
#   dogapi { version = "1.45.0"; }
#   dogapi { }  # latest (1.45.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.45.0",
  git ? { },
}:
let
  versions = {
    "1.43.0" = import ./1.43.0 { inherit lib stdenv ruby; };
    "1.44.0" = import ./1.44.0 { inherit lib stdenv ruby; };
    "1.45.0" = import ./1.45.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dogapi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "dogapi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
