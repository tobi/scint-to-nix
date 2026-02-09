#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# formatador
#
# Available versions:
#   1.1.0
#   1.2.1
#   1.2.2
#   1.2.3
#
# Usage:
#   formatador { version = "1.2.3"; }
#   formatador { }  # latest (1.2.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.3",
  git ? { },
}:
let
  versions = {
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
    "1.2.3" = import ./1.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "formatador: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "formatador: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
