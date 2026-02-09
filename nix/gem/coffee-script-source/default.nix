#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-script-source
#
# Available versions:
#   1.11.0
#   1.11.1
#   1.12.2
#
# Usage:
#   coffee-script-source { version = "1.12.2"; }
#   coffee-script-source { }  # latest (1.12.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.12.2",
  git ? { },
}:
let
  versions = {
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
    "1.12.2" = import ./1.12.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "coffee-script-source: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "coffee-script-source: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
