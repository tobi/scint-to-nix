#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sigdump
#
# Available versions:
#   0.2.3
#   0.2.4
#   0.2.5
#
# Usage:
#   sigdump { version = "0.2.5"; }
#   sigdump { }  # latest (0.2.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.5",
  git ? { },
}:
let
  versions = {
    "0.2.3" = import ./0.2.3 { inherit lib stdenv ruby; };
    "0.2.4" = import ./0.2.4 { inherit lib stdenv ruby; };
    "0.2.5" = import ./0.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sigdump: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sigdump: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
