#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-kubernetes_metadata_filter
#
# Available versions:
#   3.7.0
#   3.7.1
#   3.8.0
#
# Usage:
#   fluent-plugin-kubernetes_metadata_filter { version = "3.8.0"; }
#   fluent-plugin-kubernetes_metadata_filter { }  # latest (3.8.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.8.0",
  git ? { },
}:
let
  versions = {
    "3.7.0" = import ./3.7.0 { inherit lib stdenv ruby; };
    "3.7.1" = import ./3.7.1 { inherit lib stdenv ruby; };
    "3.8.0" = import ./3.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluent-plugin-kubernetes_metadata_filter: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fluent-plugin-kubernetes_metadata_filter: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
