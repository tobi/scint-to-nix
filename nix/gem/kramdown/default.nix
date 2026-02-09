#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kramdown
#
# Available versions:
#   2.4.0
#   2.5.0
#   2.5.1
#   2.5.2
#
# Usage:
#   kramdown { version = "2.5.2"; }
#   kramdown { }  # latest (2.5.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.2",
  git ? { },
}:
let
  versions = {
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
    "2.5.2" = import ./2.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kramdown: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "kramdown: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
