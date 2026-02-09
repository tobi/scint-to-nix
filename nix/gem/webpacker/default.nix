#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webpacker
#
# Available versions:
#   5.4.2
#   5.4.3
#   5.4.4
#
# Usage:
#   webpacker { version = "5.4.4"; }
#   webpacker { }  # latest (5.4.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.4",
  git ? { },
}:
let
  versions = {
    "5.4.2" = import ./5.4.2 { inherit lib stdenv ruby; };
    "5.4.3" = import ./5.4.3 { inherit lib stdenv ruby; };
    "5.4.4" = import ./5.4.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webpacker: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "webpacker: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
