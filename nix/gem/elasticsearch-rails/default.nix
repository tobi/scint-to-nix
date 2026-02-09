#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-rails
#
# Available versions:
#   7.2.1
#   8.0.0
#   8.0.1
#
# Usage:
#   elasticsearch-rails { version = "8.0.1"; }
#   elasticsearch-rails { }  # latest (8.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.1",
  git ? { },
}:
let
  versions = {
    "7.2.1" = import ./7.2.1 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "8.0.1" = import ./8.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elasticsearch-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "elasticsearch-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
