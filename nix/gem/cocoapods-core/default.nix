#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-core
#
# Available versions:
#   1.16.0
#   1.16.1
#   1.16.2
#
# Usage:
#   cocoapods-core { version = "1.16.2"; }
#   cocoapods-core { }  # latest (1.16.2)
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
    or (throw "cocoapods-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cocoapods-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
