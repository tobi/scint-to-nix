#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# handlebars_assets
#
# Available versions:
#   0.23.9
#
# Usage:
#   handlebars_assets { version = "0.23.9"; }
#   handlebars_assets { }  # latest (0.23.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.23.9",
  git ? { },
}:
let
  versions = {
    "0.23.9" = import ./0.23.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "handlebars_assets: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "handlebars_assets: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
