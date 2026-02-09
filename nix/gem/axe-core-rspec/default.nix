#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# axe-core-rspec
#
# Available versions:
#   4.11.1
#
# Usage:
#   axe-core-rspec { version = "4.11.1"; }
#   axe-core-rspec { }  # latest (4.11.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.11.1",
  git ? { },
}:
let
  versions = {
    "4.11.1" = import ./4.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "axe-core-rspec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "axe-core-rspec: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
