#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-aws
#
# Available versions:
#   3.21.0
#   3.32.0
#   3.33.0
#   3.33.1
#
# Usage:
#   fog-aws { version = "3.33.1"; }
#   fog-aws { }  # latest (3.33.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.33.1",
  git ? { },
}:
let
  versions = {
    "3.21.0" = import ./3.21.0 { inherit lib stdenv ruby; };
    "3.32.0" = import ./3.32.0 { inherit lib stdenv ruby; };
    "3.33.0" = import ./3.33.0 { inherit lib stdenv ruby; };
    "3.33.1" = import ./3.33.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-aws: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fog-aws: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
