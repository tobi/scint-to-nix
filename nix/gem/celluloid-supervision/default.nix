#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-supervision
#
# Available versions:
#   0.20.1.1
#   0.20.5
#   0.20.6
#
# Usage:
#   celluloid-supervision { version = "0.20.6"; }
#   celluloid-supervision { }  # latest (0.20.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.6",
  git ? { },
}:
let
  versions = {
    "0.20.1.1" = import ./0.20.1.1 { inherit lib stdenv ruby; };
    "0.20.5" = import ./0.20.5 { inherit lib stdenv ruby; };
    "0.20.6" = import ./0.20.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "celluloid-supervision: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "celluloid-supervision: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
