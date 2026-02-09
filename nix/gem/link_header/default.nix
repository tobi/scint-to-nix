#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# link_header
#
# Available versions:
#   0.0.8
#
# Usage:
#   link_header { version = "0.0.8"; }
#   link_header { }  # latest (0.0.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.8",
  git ? { },
}:
let
  versions = {
    "0.0.8" = import ./0.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "link_header: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "link_header: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
