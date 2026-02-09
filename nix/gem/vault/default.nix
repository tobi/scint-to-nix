#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vault
#
# Available versions:
#   0.18.2
#   0.19.0
#   0.20.0
#
# Usage:
#   vault { version = "0.20.0"; }
#   vault { }  # latest (0.20.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.0",
  git ? { },
}:
let
  versions = {
    "0.18.2" = import ./0.18.2 { inherit lib stdenv ruby; };
    "0.19.0" = import ./0.19.0 { inherit lib stdenv ruby; };
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vault: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "vault: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
