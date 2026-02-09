#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# better_html
#
# Available versions:
#   2.0.2
#
# Usage:
#   better_html { version = "2.0.2"; }
#   better_html { }  # latest (2.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.2",
  git ? { },
}:
let
  versions = {
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "better_html: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "better_html: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
