#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strong_migrations
#
# Available versions:
#   1.8.0
#   2.5.0
#   2.5.1
#   2.5.2
#
# Usage:
#   strong_migrations { version = "2.5.2"; }
#   strong_migrations { }  # latest (2.5.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.2",
  git ? { },
}:
let
  versions = {
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
    "2.5.2" = import ./2.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "strong_migrations: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "strong_migrations: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
