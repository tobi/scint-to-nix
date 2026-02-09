#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activeresource
#
# Available versions:
#   6.1.3
#   6.1.4
#   6.2.0
#
# Usage:
#   activeresource { version = "6.2.0"; }
#   activeresource { }  # latest (6.2.0)
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
    "6.1.3" = import ./6.1.3 { inherit lib stdenv ruby; };
    "6.1.4" = import ./6.1.4 { inherit lib stdenv ruby; };
    "6.2.0" = import ./6.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "activeresource: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "activeresource: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
