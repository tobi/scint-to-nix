#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mdl
#
# Available versions:
#   0.12.0
#
# Usage:
#   mdl { version = "0.12.0"; }
#   mdl { }  # latest (0.12.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.12.0",
  git ? { },
}:
let
  versions = {
    "0.12.0" = import ./0.12.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mdl: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mdl: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
