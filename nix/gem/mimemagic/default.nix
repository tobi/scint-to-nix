#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mimemagic
#
# Available versions:
#   0.4.1
#   0.4.2
#   0.4.3
#
# Usage:
#   mimemagic { version = "0.4.3"; }
#   mimemagic { }  # latest (0.4.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.3",
  git ? { },
}:
let
  versions = {
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
    "0.4.2" = import ./0.4.2 { inherit lib stdenv ruby; };
    "0.4.3" = import ./0.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mimemagic: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mimemagic: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
