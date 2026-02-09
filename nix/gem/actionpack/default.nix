#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionpack
#
# Available versions:
#   7.0.8.7
#   7.1.5.2
#   8.0.3
#   8.0.4
#   8.1.0
#   8.1.1
#   8.1.2
#
# Usage:
#   actionpack { version = "8.1.2"; }
#   actionpack { }  # latest (8.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.1.2",
  git ? { },
}:
let
  versions = {
    "7.0.8.7" = import ./7.0.8.7 { inherit lib stdenv ruby; };
    "7.1.5.2" = import ./7.1.5.2 { inherit lib stdenv ruby; };
    "8.0.3" = import ./8.0.3 { inherit lib stdenv ruby; };
    "8.0.4" = import ./8.0.4 { inherit lib stdenv ruby; };
    "8.1.0" = import ./8.1.0 { inherit lib stdenv ruby; };
    "8.1.1" = import ./8.1.1 { inherit lib stdenv ruby; };
    "8.1.2" = import ./8.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "actionpack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "actionpack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
