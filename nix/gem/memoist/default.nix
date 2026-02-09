#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# memoist
#
# Available versions:
#   0.16.0
#   0.16.1
#   0.16.2
#
# Usage:
#   memoist { version = "0.16.2"; }
#   memoist { }  # latest (0.16.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.16.2",
  git ? { },
}:
let
  versions = {
    "0.16.0" = import ./0.16.0 { inherit lib stdenv ruby; };
    "0.16.1" = import ./0.16.1 { inherit lib stdenv ruby; };
    "0.16.2" = import ./0.16.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "memoist: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "memoist: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
