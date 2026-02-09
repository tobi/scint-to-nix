#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libdatadog
#
# Available versions:
#   5.0.0.1.0
#   18.1.0.1.0
#   24.0.1.1.0
#   25.0.0.1.0
#   26.0.0.1.0
#
# Usage:
#   libdatadog { version = "26.0.0.1.0"; }
#   libdatadog { }  # latest (26.0.0.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "26.0.0.1.0",
  git ? { },
}:
let
  versions = {
    "5.0.0.1.0" = import ./5.0.0.1.0 { inherit lib stdenv ruby; };
    "18.1.0.1.0" = import ./18.1.0.1.0 { inherit lib stdenv ruby; };
    "24.0.1.1.0" = import ./24.0.1.1.0 { inherit lib stdenv ruby; };
    "25.0.0.1.0" = import ./25.0.0.1.0 { inherit lib stdenv ruby; };
    "26.0.0.1.0" = import ./26.0.0.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libdatadog: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "libdatadog: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
