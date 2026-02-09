#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-minitest
#
# Available versions:
#   0.37.1
#
# Usage:
#   rubocop-minitest { version = "0.37.1"; }
#   rubocop-minitest { }  # latest (0.37.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.37.1",
  git ? { },
}:
let
  versions = {
    "0.37.1" = import ./0.37.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-minitest: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-minitest: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
