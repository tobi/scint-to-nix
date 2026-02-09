#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cucumber-wire
#
# Available versions:
#   6.2.1
#   7.0.0
#   8.0.0
#
# Usage:
#   cucumber-wire { version = "8.0.0"; }
#   cucumber-wire { }  # latest (8.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.0",
  git ? { },
}:
let
  versions = {
    "6.2.1" = import ./6.2.1 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cucumber-wire: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cucumber-wire: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
