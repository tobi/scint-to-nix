#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# terser
#
# Available versions:
#   1.2.2
#   1.2.4
#   1.2.5
#   1.2.6
#
# Usage:
#   terser { version = "1.2.6"; }
#   terser { }  # latest (1.2.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.6",
  git ? { },
}:
let
  versions = {
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
    "1.2.6" = import ./1.2.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "terser: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "terser: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
