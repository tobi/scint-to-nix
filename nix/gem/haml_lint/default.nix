#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# haml_lint
#
# Available versions:
#   0.67.0
#   0.68.0
#   0.69.0
#
# Usage:
#   haml_lint { version = "0.69.0"; }
#   haml_lint { }  # latest (0.69.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.69.0",
  git ? { },
}:
let
  versions = {
    "0.67.0" = import ./0.67.0 { inherit lib stdenv ruby; };
    "0.68.0" = import ./0.68.0 { inherit lib stdenv ruby; };
    "0.69.0" = import ./0.69.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "haml_lint: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "haml_lint: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
