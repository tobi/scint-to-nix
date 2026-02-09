#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# haml
#
# Available versions:
#   7.0.2
#   7.1.0
#   7.2.0
#
# Usage:
#   haml { version = "7.2.0"; }
#   haml { }  # latest (7.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.2.0",
  git ? { },
}:
let
  versions = {
    "7.0.2" = import ./7.0.2 { inherit lib stdenv ruby; };
    "7.1.0" = import ./7.1.0 { inherit lib stdenv ruby; };
    "7.2.0" = import ./7.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "haml: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "haml: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
