#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# roadie-rails
#
# Available versions:
#   3.4.0
#
# Usage:
#   roadie-rails { version = "3.4.0"; }
#   roadie-rails { }  # latest (3.4.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.0",
  git ? { },
}:
let
  versions = {
    "3.4.0" = import ./3.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "roadie-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "roadie-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
