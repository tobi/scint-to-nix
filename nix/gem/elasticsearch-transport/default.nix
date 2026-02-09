#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-transport
#
# Available versions:
#   7.17.9
#   7.17.10
#   7.17.11
#
# Usage:
#   elasticsearch-transport { version = "7.17.11"; }
#   elasticsearch-transport { }  # latest (7.17.11)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.17.11",
  git ? { },
}:
let
  versions = {
    "7.17.9" = import ./7.17.9 { inherit lib stdenv ruby; };
    "7.17.10" = import ./7.17.10 { inherit lib stdenv ruby; };
    "7.17.11" = import ./7.17.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elasticsearch-transport: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "elasticsearch-transport: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
