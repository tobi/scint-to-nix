#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-downloader
#
# Available versions:
#   1.6.3
#   2.0
#   2.1
#
# Usage:
#   cocoapods-downloader { version = "2.1"; }
#   cocoapods-downloader { }  # latest (2.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1",
  git ? { },
}:
let
  versions = {
    "1.6.3" = import ./1.6.3 { inherit lib stdenv ruby; };
    "2.0" = import ./2.0 { inherit lib stdenv ruby; };
    "2.1" = import ./2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoapods-downloader: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cocoapods-downloader: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
