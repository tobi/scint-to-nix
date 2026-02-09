#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fast_sqlite
#
# Available versions:
#   0.0.1
#
# Usage:
#   fast_sqlite { version = "0.0.1"; }
#   fast_sqlite { }  # latest (0.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.1",
  git ? { },
}:
let
  versions = {
    "0.0.1" = import ./0.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fast_sqlite: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fast_sqlite: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
