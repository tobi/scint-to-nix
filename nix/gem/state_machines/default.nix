#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines
#
# Available versions:
#   0.6.0
#   0.100.1
#   0.100.2
#   0.100.4
#
# Usage:
#   state_machines { version = "0.100.4"; }
#   state_machines { }  # latest (0.100.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.100.4",
  git ? { },
}:
let
  versions = {
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.100.1" = import ./0.100.1 { inherit lib stdenv ruby; };
    "0.100.2" = import ./0.100.2 { inherit lib stdenv ruby; };
    "0.100.4" = import ./0.100.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "state_machines: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "state_machines: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
