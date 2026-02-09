#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-parser
#
# Available versions:
#   1.2.1
#   1.2.2
#   1.2.3
#
# Usage:
#   http-parser { version = "1.2.3"; }
#   http-parser { }  # latest (1.2.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.3",
  git ? { },
}:
let
  versions = {
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
    "1.2.3" = import ./1.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http-parser: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "http-parser: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
