#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bugsnag
#
# Available versions:
#   6.27.1
#   6.28.0
#   6.29.0
#
# Usage:
#   bugsnag { version = "6.29.0"; }
#   bugsnag { }  # latest (6.29.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.29.0",
  git ? { },
}:
let
  versions = {
    "6.27.1" = import ./6.27.1 { inherit lib stdenv ruby; };
    "6.28.0" = import ./6.28.0 { inherit lib stdenv ruby; };
    "6.29.0" = import ./6.29.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bugsnag: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bugsnag: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
