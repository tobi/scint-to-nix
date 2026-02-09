#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# premailer
#
# Available versions:
#   1.25.0
#   1.26.0
#   1.27.0
#
# Usage:
#   premailer { version = "1.27.0"; }
#   premailer { }  # latest (1.27.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.27.0",
  git ? { },
}:
let
  versions = {
    "1.25.0" = import ./1.25.0 { inherit lib stdenv ruby; };
    "1.26.0" = import ./1.26.0 { inherit lib stdenv ruby; };
    "1.27.0" = import ./1.27.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "premailer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "premailer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
