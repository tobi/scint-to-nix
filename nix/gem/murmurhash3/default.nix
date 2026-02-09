#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# murmurhash3
#
# Available versions:
#   0.1.5
#   0.1.6
#   0.1.7
#
# Usage:
#   murmurhash3 { version = "0.1.7"; }
#   murmurhash3 { }  # latest (0.1.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.7",
  git ? { },
}:
let
  versions = {
    "0.1.5" = import ./0.1.5 { inherit lib stdenv ruby; };
    "0.1.6" = import ./0.1.6 { inherit lib stdenv ruby; };
    "0.1.7" = import ./0.1.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "murmurhash3: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "murmurhash3: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
