#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activemerchant
#
# Available versions:
#   1.137.0
#
# Usage:
#   activemerchant { version = "1.137.0"; }
#   activemerchant { }  # latest (1.137.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.137.0",
  git ? { },
}:
let
  versions = {
    "1.137.0" = import ./1.137.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "activemerchant: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "activemerchant: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
