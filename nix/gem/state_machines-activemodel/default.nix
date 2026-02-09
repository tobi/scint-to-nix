#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines-activemodel
#
# Available versions:
#   0.9.0
#   0.31.2
#   0.100.0
#   0.101.0
#
# Usage:
#   state_machines-activemodel { version = "0.101.0"; }
#   state_machines-activemodel { }  # latest (0.101.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.101.0",
  git ? { },
}:
let
  versions = {
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.31.2" = import ./0.31.2 { inherit lib stdenv ruby; };
    "0.100.0" = import ./0.100.0 { inherit lib stdenv ruby; };
    "0.101.0" = import ./0.101.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "state_machines-activemodel: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "state_machines-activemodel: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
