#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erb-formatter
#
# Available versions:
#   0.7.3
#
# Usage:
#   erb-formatter { version = "0.7.3"; }
#   erb-formatter { }  # latest (0.7.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.3",
  git ? { },
}:
let
  versions = {
    "0.7.3" = import ./0.7.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "erb-formatter: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "erb-formatter: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
