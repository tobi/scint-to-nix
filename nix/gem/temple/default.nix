#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# temple
#
# Available versions:
#   0.10.2
#   0.10.3
#   0.10.4
#
# Usage:
#   temple { version = "0.10.4"; }
#   temple { }  # latest (0.10.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.4",
  git ? { },
}:
let
  versions = {
    "0.10.2" = import ./0.10.2 { inherit lib stdenv ruby; };
    "0.10.3" = import ./0.10.3 { inherit lib stdenv ruby; };
    "0.10.4" = import ./0.10.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "temple: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "temple: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
