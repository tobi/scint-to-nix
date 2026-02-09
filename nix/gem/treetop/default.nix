#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# treetop
#
# Available versions:
#   1.6.16
#   1.6.17
#   1.6.18
#
# Usage:
#   treetop { version = "1.6.18"; }
#   treetop { }  # latest (1.6.18)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.18",
  git ? { },
}:
let
  versions = {
    "1.6.16" = import ./1.6.16 { inherit lib stdenv ruby; };
    "1.6.17" = import ./1.6.17 { inherit lib stdenv ruby; };
    "1.6.18" = import ./1.6.18 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "treetop: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "treetop: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
