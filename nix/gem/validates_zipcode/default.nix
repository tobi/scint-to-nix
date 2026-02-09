#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validates_zipcode
#
# Available versions:
#   0.5.4
#
# Usage:
#   validates_zipcode { version = "0.5.4"; }
#   validates_zipcode { }  # latest (0.5.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.4",
  git ? { },
}:
let
  versions = {
    "0.5.4" = import ./0.5.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "validates_zipcode: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "validates_zipcode: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
