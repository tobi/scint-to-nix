#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-i18n
#
# Available versions:
#   3.2.3
#
# Usage:
#   rubocop-i18n { version = "3.2.3"; }
#   rubocop-i18n { }  # latest (3.2.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.3",
  git ? { },
}:
let
  versions = {
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-i18n: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-i18n: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
