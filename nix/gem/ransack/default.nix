#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ransack
#
# Available versions:
#   3.2.1
#   4.3.0
#   4.4.0
#   4.4.1
#
# Usage:
#   ransack { version = "4.4.1"; }
#   ransack { }  # latest (4.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.1",
  git ? { },
}:
let
  versions = {
    "3.2.1" = import ./3.2.1 { inherit lib stdenv ruby; };
    "4.3.0" = import ./4.3.0 { inherit lib stdenv ruby; };
    "4.4.0" = import ./4.4.0 { inherit lib stdenv ruby; };
    "4.4.1" = import ./4.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ransack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ransack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
