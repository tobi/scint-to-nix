#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# blazer
#
# Available versions:
#   2.6.5
#
# Usage:
#   blazer { version = "2.6.5"; }
#   blazer { }  # latest (2.6.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.5",
  git ? { },
}:
let
  versions = {
    "2.6.5" = import ./2.6.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "blazer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "blazer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
