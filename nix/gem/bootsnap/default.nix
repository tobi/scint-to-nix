#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bootsnap
#
# Available versions:
#   1.16.0
#   1.18.3
#   1.18.4
#   1.19.0
#   1.20.1
#   1.21.0
#   1.21.1
#   1.22.0
#
# Usage:
#   bootsnap { version = "1.22.0"; }
#   bootsnap { }  # latest (1.22.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.22.0",
  git ? { },
}:
let
  versions = {
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.18.3" = import ./1.18.3 { inherit lib stdenv ruby; };
    "1.18.4" = import ./1.18.4 { inherit lib stdenv ruby; };
    "1.19.0" = import ./1.19.0 { inherit lib stdenv ruby; };
    "1.20.1" = import ./1.20.1 { inherit lib stdenv ruby; };
    "1.21.0" = import ./1.21.0 { inherit lib stdenv ruby; };
    "1.21.1" = import ./1.21.1 { inherit lib stdenv ruby; };
    "1.22.0" = import ./1.22.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bootsnap: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bootsnap: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
