#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# power_assert
#
# Available versions:
#   2.0.5
#   3.0.0
#   3.0.1
#
# Usage:
#   power_assert { version = "3.0.1"; }
#   power_assert { }  # latest (3.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.1",
  git ? { },
}:
let
  versions = {
    "2.0.5" = import ./2.0.5 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "power_assert: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "power_assert: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
