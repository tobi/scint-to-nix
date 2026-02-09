#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# doorkeeper-i18n
#
# Available versions:
#   5.2.8
#
# Usage:
#   doorkeeper-i18n { version = "5.2.8"; }
#   doorkeeper-i18n { }  # latest (5.2.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.8",
  git ? { },
}:
let
  versions = {
    "5.2.8" = import ./5.2.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "doorkeeper-i18n: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "doorkeeper-i18n: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
