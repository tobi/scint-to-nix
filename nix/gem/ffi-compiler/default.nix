#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffi-compiler
#
# Available versions:
#   1.0.1
#   1.3.1
#   1.3.2
#
# Usage:
#   ffi-compiler { version = "1.3.2"; }
#   ffi-compiler { }  # latest (1.3.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.2",
  git ? { },
}:
let
  versions = {
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
    "1.3.2" = import ./1.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ffi-compiler: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ffi-compiler: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
