#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry-byebug
#
# Available versions:
#   3.10.1
#   3.11.0
#   3.12.0
#
# Usage:
#   pry-byebug { version = "3.12.0"; }
#   pry-byebug { }  # latest (3.12.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.12.0",
  git ? { },
}:
let
  versions = {
    "3.10.1" = import ./3.10.1 { inherit lib stdenv ruby; };
    "3.11.0" = import ./3.11.0 { inherit lib stdenv ruby; };
    "3.12.0" = import ./3.12.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pry-byebug: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pry-byebug: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
