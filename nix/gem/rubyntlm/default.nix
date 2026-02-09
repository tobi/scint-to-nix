#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubyntlm
#
# Available versions:
#   0.6.3
#   0.6.4
#   0.6.5
#
# Usage:
#   rubyntlm { version = "0.6.5"; }
#   rubyntlm { }  # latest (0.6.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.5",
  git ? { },
}:
let
  versions = {
    "0.6.3" = import ./0.6.3 { inherit lib stdenv ruby; };
    "0.6.4" = import ./0.6.4 { inherit lib stdenv ruby; };
    "0.6.5" = import ./0.6.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubyntlm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubyntlm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
