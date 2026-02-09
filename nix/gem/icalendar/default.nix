#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# icalendar
#
# Available versions:
#   2.11.2
#   2.12.0
#   2.12.1
#
# Usage:
#   icalendar { version = "2.12.1"; }
#   icalendar { }  # latest (2.12.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.12.1",
  git ? { },
}:
let
  versions = {
    "2.11.2" = import ./2.11.2 { inherit lib stdenv ruby; };
    "2.12.0" = import ./2.12.0 { inherit lib stdenv ruby; };
    "2.12.1" = import ./2.12.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "icalendar: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "icalendar: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
