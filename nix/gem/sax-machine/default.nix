#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sax-machine
#
# Available versions:
#   1.3.2
#
# Usage:
#   sax-machine { version = "1.3.2"; }
#   sax-machine { }  # latest (1.3.2)
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
    "1.3.2" = import ./1.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sax-machine: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sax-machine: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
