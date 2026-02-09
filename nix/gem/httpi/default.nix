#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httpi
#
# Available versions:
#   4.0.2
#   4.0.3
#   4.0.4
#
# Usage:
#   httpi { version = "4.0.4"; }
#   httpi { }  # latest (4.0.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.4",
  git ? { },
}:
let
  versions = {
    "4.0.2" = import ./4.0.2 { inherit lib stdenv ruby; };
    "4.0.3" = import ./4.0.3 { inherit lib stdenv ruby; };
    "4.0.4" = import ./4.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "httpi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "httpi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
