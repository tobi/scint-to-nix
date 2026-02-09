#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# backports
#
# Available versions:
#   3.25.1
#   3.25.2
#   3.25.3
#
# Usage:
#   backports { version = "3.25.3"; }
#   backports { }  # latest (3.25.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.25.3",
  git ? { },
}:
let
  versions = {
    "3.25.1" = import ./3.25.1 { inherit lib stdenv ruby; };
    "3.25.2" = import ./3.25.2 { inherit lib stdenv ruby; };
    "3.25.3" = import ./3.25.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "backports: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "backports: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
