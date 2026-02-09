#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# honeycomb-beeline
#
# Available versions:
#   2.11.0
#
# Usage:
#   honeycomb-beeline { version = "2.11.0"; }
#   honeycomb-beeline { }  # latest (2.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.11.0",
  git ? { },
}:
let
  versions = {
    "2.11.0" = import ./2.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "honeycomb-beeline: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "honeycomb-beeline: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
