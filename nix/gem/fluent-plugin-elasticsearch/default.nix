#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-elasticsearch
#
# Available versions:
#   5.4.3
#   5.4.4
#   6.0.0
#
# Usage:
#   fluent-plugin-elasticsearch { version = "6.0.0"; }
#   fluent-plugin-elasticsearch { }  # latest (6.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.0.0",
  git ? { },
}:
let
  versions = {
    "5.4.3" = import ./5.4.3 { inherit lib stdenv ruby; };
    "5.4.4" = import ./5.4.4 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluent-plugin-elasticsearch: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fluent-plugin-elasticsearch: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
