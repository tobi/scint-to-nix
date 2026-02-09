#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# browser
#
# Available versions:
#   5.3.1
#   6.0.0
#   6.1.0
#   6.2.0
#
# Usage:
#   browser { version = "6.2.0"; }
#   browser { }  # latest (6.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.2.0",
  git ? { },
}:
let
  versions = {
    "5.3.1" = import ./5.3.1 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
    "6.2.0" = import ./6.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "browser: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "browser: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
