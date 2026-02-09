#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solargraph-rails
#
# Available versions:
#   0.3.1
#
# Usage:
#   solargraph-rails { version = "0.3.1"; }
#   solargraph-rails { }  # latest (0.3.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.1",
  git ? { },
}:
let
  versions = {
    "0.3.1" = import ./0.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solargraph-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "solargraph-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
