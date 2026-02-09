#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n-tasks
#
# Available versions:
#   0.9.37
#   1.0.13
#   1.1.2
#
# Usage:
#   i18n-tasks { version = "1.1.2"; }
#   i18n-tasks { }  # latest (1.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.2",
  git ? { },
}:
let
  versions = {
    "0.9.37" = import ./0.9.37 { inherit lib stdenv ruby; };
    "1.0.13" = import ./1.0.13 { inherit lib stdenv ruby; };
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "i18n-tasks: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "i18n-tasks: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
