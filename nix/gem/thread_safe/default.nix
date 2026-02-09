#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thread_safe
#
# Available versions:
#   0.3.4
#   0.3.5
#   0.3.6
#
# Usage:
#   thread_safe { version = "0.3.6"; }
#   thread_safe { }  # latest (0.3.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.6",
  git ? { },
}:
let
  versions = {
    "0.3.4" = import ./0.3.4 { inherit lib stdenv ruby; };
    "0.3.5" = import ./0.3.5 { inherit lib stdenv ruby; };
    "0.3.6" = import ./0.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "thread_safe: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "thread_safe: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
