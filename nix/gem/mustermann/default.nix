#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mustermann
#
# Available versions:
#   3.0.2
#   3.0.3
#   3.0.4
#
# Usage:
#   mustermann { version = "3.0.4"; }
#   mustermann { }  # latest (3.0.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.4",
  git ? { },
}:
let
  versions = {
    "3.0.2" = import ./3.0.2 { inherit lib stdenv ruby; };
    "3.0.3" = import ./3.0.3 { inherit lib stdenv ruby; };
    "3.0.4" = import ./3.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mustermann: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mustermann: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
