#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activemodel-serializers-xml
#
# Available versions:
#   1.0.1
#   1.0.2
#   1.0.3
#
# Usage:
#   activemodel-serializers-xml { version = "1.0.3"; }
#   activemodel-serializers-xml { }  # latest (1.0.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.3",
  git ? { },
}:
let
  versions = {
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "activemodel-serializers-xml: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "activemodel-serializers-xml: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
