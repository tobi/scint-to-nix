#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solargraph
#
# Available versions:
#   0.50.0
#   0.59.0.dev.1
#
# Usage:
#   solargraph { version = "0.59.0.dev.1"; }
#   solargraph { }  # latest (0.59.0.dev.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.59.0.dev.1",
  git ? { },
}:
let
  versions = {
    "0.50.0" = import ./0.50.0 { inherit lib stdenv ruby; };
    "0.59.0.dev.1" = import ./0.59.0.dev.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solargraph: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "solargraph: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
