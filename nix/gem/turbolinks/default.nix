#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbolinks
#
# Available versions:
#   5.1.1
#   5.2.0
#   5.2.1
#
# Usage:
#   turbolinks { version = "5.2.1"; }
#   turbolinks { }  # latest (5.2.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.1",
  git ? { },
}:
let
  versions = {
    "5.1.1" = import ./5.1.1 { inherit lib stdenv ruby; };
    "5.2.0" = import ./5.2.0 { inherit lib stdenv ruby; };
    "5.2.1" = import ./5.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "turbolinks: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "turbolinks: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
