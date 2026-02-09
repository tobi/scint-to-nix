#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# llhttp-ffi
#
# Available versions:
#   0.4.0
#   0.5.0
#   0.5.1
#
# Usage:
#   llhttp-ffi { version = "0.5.1"; }
#   llhttp-ffi { }  # latest (0.5.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.1",
  git ? { },
}:
let
  versions = {
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "llhttp-ffi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "llhttp-ffi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
