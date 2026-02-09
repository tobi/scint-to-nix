#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gpgme
#
# Available versions:
#   2.0.23
#   2.0.24
#   2.0.25
#
# Usage:
#   gpgme { version = "2.0.25"; }
#   gpgme { }  # latest (2.0.25)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.25",
  git ? { },
}:
let
  versions = {
    "2.0.23" = import ./2.0.23 { inherit lib stdenv ruby; };
    "2.0.24" = import ./2.0.24 { inherit lib stdenv ruby; };
    "2.0.25" = import ./2.0.25 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gpgme: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gpgme: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
