#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# trollop
#
# Available versions:
#   2.1.3
#   2.9.9
#   2.9.10
#
# Usage:
#   trollop { version = "2.9.10"; }
#   trollop { }  # latest (2.9.10)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.9.10",
  git ? { },
}:
let
  versions = {
    "2.1.3" = import ./2.1.3 { inherit lib stdenv ruby; };
    "2.9.9" = import ./2.9.9 { inherit lib stdenv ruby; };
    "2.9.10" = import ./2.9.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "trollop: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "trollop: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
