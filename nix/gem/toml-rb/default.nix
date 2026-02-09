#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# toml-rb
#
# Available versions:
#   3.0.1
#   4.0.0
#   4.1.0
#
# Usage:
#   toml-rb { version = "4.1.0"; }
#   toml-rb { }  # latest (4.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.0",
  git ? { },
}:
let
  versions = {
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "toml-rb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "toml-rb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
