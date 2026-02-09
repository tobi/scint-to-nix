#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n-js
#
# Available versions:
#   3.9.2
#
# Usage:
#   i18n-js { version = "3.9.2"; }
#   i18n-js { }  # latest (3.9.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.2",
  git ? { },
}:
let
  versions = {
    "3.9.2" = import ./3.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "i18n-js: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "i18n-js: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
