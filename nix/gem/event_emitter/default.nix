#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# event_emitter
#
# Available versions:
#   0.2.6
#
# Usage:
#   event_emitter { version = "0.2.6"; }
#   event_emitter { }  # latest (0.2.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.6",
  git ? { },
}:
let
  versions = {
    "0.2.6" = import ./0.2.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "event_emitter: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "event_emitter: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
