#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# axiom-types
#
# Available versions:
#   0.0.5
#   0.1.0
#   0.1.1
#
# Usage:
#   axiom-types { version = "0.1.1"; }
#   axiom-types { }  # latest (0.1.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.1",
  git ? { },
}:
let
  versions = {
    "0.0.5" = import ./0.0.5 { inherit lib stdenv ruby; };
    "0.1.0" = import ./0.1.0 { inherit lib stdenv ruby; };
    "0.1.1" = import ./0.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "axiom-types: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "axiom-types: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
