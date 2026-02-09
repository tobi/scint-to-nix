#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xcpretty
#
# Available versions:
#   0.3.0
#   0.4.0
#   0.4.1
#
# Usage:
#   xcpretty { version = "0.4.1"; }
#   xcpretty { }  # latest (0.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.1",
  git ? { },
}:
let
  versions = {
    "0.3.0" = import ./0.3.0 { inherit lib stdenv ruby; };
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "xcpretty: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "xcpretty: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
