#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gettext
#
# Available versions:
#   3.4.9
#   3.5.0
#   3.5.1
#
# Usage:
#   gettext { version = "3.5.1"; }
#   gettext { }  # latest (3.5.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.1",
  git ? { },
}:
let
  versions = {
    "3.4.9" = import ./3.4.9 { inherit lib stdenv ruby; };
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
    "3.5.1" = import ./3.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gettext: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gettext: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
