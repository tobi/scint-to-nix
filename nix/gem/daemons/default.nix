#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# daemons
#
# Available versions:
#   1.3.1
#   1.4.0
#   1.4.1
#
# Usage:
#   daemons { version = "1.4.1"; }
#   daemons { }  # latest (1.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.1",
  git ? { },
}:
let
  versions = {
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
    "1.4.1" = import ./1.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "daemons: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "daemons: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
