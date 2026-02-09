#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_model_serializers
#
# Available versions:
#   0.8.4
#   0.10.14
#   0.10.15
#   0.10.16
#
# Usage:
#   active_model_serializers { version = "0.10.16"; }
#   active_model_serializers { }  # latest (0.10.16)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.16",
  git ? { },
}:
let
  versions = {
    "0.8.4" = import ./0.8.4 { inherit lib stdenv ruby; };
    "0.10.14" = import ./0.10.14 { inherit lib stdenv ruby; };
    "0.10.15" = import ./0.10.15 { inherit lib stdenv ruby; };
    "0.10.16" = import ./0.10.16 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "active_model_serializers: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "active_model_serializers: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
