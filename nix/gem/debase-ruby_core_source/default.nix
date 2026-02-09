#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# debase-ruby_core_source
#
# Available versions:
#   3.2.2
#   3.3.6
#   3.4.1
#   4.0.0
#
# Usage:
#   debase-ruby_core_source { version = "4.0.0"; }
#   debase-ruby_core_source { }  # latest (4.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0",
  git ? { },
}:
let
  versions = {
    "3.2.2" = import ./3.2.2 { inherit lib stdenv ruby; };
    "3.3.6" = import ./3.3.6 { inherit lib stdenv ruby; };
    "3.4.1" = import ./3.4.1 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "debase-ruby_core_source: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "debase-ruby_core_source: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
