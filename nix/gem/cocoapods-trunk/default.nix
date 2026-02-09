#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-trunk
#
# Available versions:
#   1.4.1
#   1.5.0
#   1.6.0
#
# Usage:
#   cocoapods-trunk { version = "1.6.0"; }
#   cocoapods-trunk { }  # latest (1.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.0",
  git ? { },
}:
let
  versions = {
    "1.4.1" = import ./1.4.1 { inherit lib stdenv ruby; };
    "1.5.0" = import ./1.5.0 { inherit lib stdenv ruby; };
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoapods-trunk: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cocoapods-trunk: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
