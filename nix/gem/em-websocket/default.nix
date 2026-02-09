#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# em-websocket
#
# Available versions:
#   0.5.1
#   0.5.2
#   0.5.3
#
# Usage:
#   em-websocket { version = "0.5.3"; }
#   em-websocket { }  # latest (0.5.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.3",
  git ? { },
}:
let
  versions = {
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
    "0.5.2" = import ./0.5.2 { inherit lib stdenv ruby; };
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "em-websocket: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "em-websocket: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
