#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbpdf
#
# Available versions:
#   1.21.4
#
# Usage:
#   rbpdf { version = "1.21.4"; }
#   rbpdf { }  # latest (1.21.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.21.4",
  git ? { },
}:
let
  versions = {
    "1.21.4" = import ./1.21.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbpdf: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rbpdf: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
