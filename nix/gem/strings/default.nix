#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strings
#
# Available versions:
#   0.1.8
#   0.2.0
#   0.2.1
#
# Usage:
#   strings { version = "0.2.1"; }
#   strings { }  # latest (0.2.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.1",
  git ? { },
}:
let
  versions = {
    "0.1.8" = import ./0.1.8 { inherit lib stdenv ruby; };
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "strings: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "strings: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
