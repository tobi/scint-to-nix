#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper
#
# Available versions:
#   0.25.4
#   1.3.4
#   1.3.5
#   1.3.6
#
# Usage:
#   flipper { version = "1.3.6"; }
#   flipper { }  # latest (1.3.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.6",
  git ? { },
}:
let
  versions = {
    "0.25.4" = import ./0.25.4 { inherit lib stdenv ruby; };
    "1.3.4" = import ./1.3.4 { inherit lib stdenv ruby; };
    "1.3.5" = import ./1.3.5 { inherit lib stdenv ruby; };
    "1.3.6" = import ./1.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flipper: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "flipper: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
