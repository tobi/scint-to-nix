#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wicked_pdf
#
# Available versions:
#   2.8.0
#   2.8.1
#   2.8.2
#
# Usage:
#   wicked_pdf { version = "2.8.2"; }
#   wicked_pdf { }  # latest (2.8.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.2",
  git ? { },
}:
let
  versions = {
    "2.8.0" = import ./2.8.0 { inherit lib stdenv ruby; };
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "2.8.2" = import ./2.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wicked_pdf: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "wicked_pdf: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
