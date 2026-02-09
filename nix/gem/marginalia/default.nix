#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# marginalia
#
# Available versions:
#   1.10.1
#   1.11.0
#   1.11.1
#
# Usage:
#   marginalia { version = "1.11.1"; }
#   marginalia { }  # latest (1.11.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.1",
  git ? { },
}:
let
  versions = {
    "1.10.1" = import ./1.10.1 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "marginalia: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "marginalia: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
