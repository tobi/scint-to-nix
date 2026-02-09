#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# socksify
#
# Available versions:
#   1.7.1
#   1.8.0
#   1.8.1
#
# Usage:
#   socksify { version = "1.8.1"; }
#   socksify { }  # latest (1.8.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.1",
  git ? { },
}:
let
  versions = {
    "1.7.1" = import ./1.7.1 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.8.1" = import ./1.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "socksify: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "socksify: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
