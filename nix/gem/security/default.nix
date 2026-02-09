#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# security
#
# Available versions:
#   0.1.3
#   0.1.4
#   0.1.5
#
# Usage:
#   security { version = "0.1.5"; }
#   security { }  # latest (0.1.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.5",
  git ? { },
}:
let
  versions = {
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
    "0.1.4" = import ./0.1.4 { inherit lib stdenv ruby; };
    "0.1.5" = import ./0.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "security: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "security: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
