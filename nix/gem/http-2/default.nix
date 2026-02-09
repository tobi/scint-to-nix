#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-2
#
# Available versions:
#   0.11.0
#
# Usage:
#   http-2 { version = "0.11.0"; }
#   http-2 { }  # latest (0.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.0",
  git ? { },
}:
let
  versions = {
    "0.11.0" = import ./0.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http-2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "http-2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
