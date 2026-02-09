#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# eventmachine
#
# Available versions:
#   1.2.5
#   1.2.6
#   1.2.7
#
# Usage:
#   eventmachine { version = "1.2.7"; }
#   eventmachine { }  # latest (1.2.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.7",
  git ? { },
}:
let
  versions = {
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
    "1.2.6" = import ./1.2.6 { inherit lib stdenv ruby; };
    "1.2.7" = import ./1.2.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "eventmachine: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "eventmachine: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
