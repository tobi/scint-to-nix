#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubygems-bundler
#
# Available versions:
#   1.4.5
#
# Usage:
#   rubygems-bundler { version = "1.4.5"; }
#   rubygems-bundler { }  # latest (1.4.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.5",
  git ? { },
}:
let
  versions = {
    "1.4.5" = import ./1.4.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubygems-bundler: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubygems-bundler: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
