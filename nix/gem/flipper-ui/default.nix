#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper-ui
#
# Available versions:
#   0.25.4
#
# Usage:
#   flipper-ui { version = "0.25.4"; }
#   flipper-ui { }  # latest (0.25.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.25.4",
  git ? { },
}:
let
  versions = {
    "0.25.4" = import ./0.25.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flipper-ui: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "flipper-ui: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
