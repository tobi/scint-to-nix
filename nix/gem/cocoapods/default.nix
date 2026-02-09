#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods
#
# Available versions:
#   1.16.0
#   1.16.1
#   1.16.2
#
# Usage:
#   cocoapods { version = "1.16.2"; }
#   cocoapods { }  # latest (1.16.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.16.2",
  git ? { },
}:
let
  versions = {
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.16.1" = import ./1.16.1 { inherit lib stdenv ruby; };
    "1.16.2" = import ./1.16.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoapods: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cocoapods: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
