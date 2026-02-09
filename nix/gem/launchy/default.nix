#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# launchy
#
# Available versions:
#   2.5.2
#   3.0.1
#   3.1.0
#   3.1.1
#
# Usage:
#   launchy { version = "3.1.1"; }
#   launchy { }  # latest (3.1.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.1",
  git ? { },
}:
let
  versions = {
    "2.5.2" = import ./2.5.2 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.1.1" = import ./3.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "launchy: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "launchy: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
