#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-shopify
#
# Available versions:
#   2.18.0
#
# Usage:
#   rubocop-shopify { version = "2.18.0"; }
#   rubocop-shopify { }  # latest (2.18.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.18.0",
  git ? { },
}:
let
  versions = {
    "2.18.0" = import ./2.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-shopify: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-shopify: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
