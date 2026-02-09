#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sexp_processor
#
# Available versions:
#   4.17.0
#   4.17.1
#   4.17.3
#   4.17.4
#   4.17.5
#
# Usage:
#   sexp_processor { version = "4.17.5"; }
#   sexp_processor { }  # latest (4.17.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.17.5",
  git ? { },
}:
let
  versions = {
    "4.17.0" = import ./4.17.0 { inherit lib stdenv ruby; };
    "4.17.1" = import ./4.17.1 { inherit lib stdenv ruby; };
    "4.17.3" = import ./4.17.3 { inherit lib stdenv ruby; };
    "4.17.4" = import ./4.17.4 { inherit lib stdenv ruby; };
    "4.17.5" = import ./4.17.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sexp_processor: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sexp_processor: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
