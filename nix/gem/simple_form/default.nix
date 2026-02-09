#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simple_form
#
# Available versions:
#   5.3.1
#   5.4.0
#   5.4.1
#
# Usage:
#   simple_form { version = "5.4.1"; }
#   simple_form { }  # latest (5.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.1",
  git ? { },
}:
let
  versions = {
    "5.3.1" = import ./5.3.1 { inherit lib stdenv ruby; };
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
    "5.4.1" = import ./5.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simple_form: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "simple_form: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
