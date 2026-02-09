#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-fsm
#
# Available versions:
#   0.20.0
#   0.20.1
#   0.20.5
#
# Usage:
#   celluloid-fsm { version = "0.20.5"; }
#   celluloid-fsm { }  # latest (0.20.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.5",
  git ? { },
}:
let
  versions = {
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
    "0.20.1" = import ./0.20.1 { inherit lib stdenv ruby; };
    "0.20.5" = import ./0.20.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "celluloid-fsm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "celluloid-fsm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
