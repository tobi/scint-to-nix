#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-shellout
#
# Available versions:
#   3.3.4
#   3.3.8
#   3.3.9
#   3.4.10
#
# Usage:
#   mixlib-shellout { version = "3.4.10"; }
#   mixlib-shellout { }  # latest (3.4.10)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.10",
  git ? { },
}:
let
  versions = {
    "3.3.4" = import ./3.3.4 { inherit lib stdenv ruby; };
    "3.3.8" = import ./3.3.8 { inherit lib stdenv ruby; };
    "3.3.9" = import ./3.3.9 { inherit lib stdenv ruby; };
    "3.4.10" = import ./3.4.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mixlib-shellout: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mixlib-shellout: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
