#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pkg-config
#
# Available versions:
#   1.6.3
#
# Usage:
#   pkg-config { version = "1.6.3"; }
#   pkg-config { }  # latest (1.6.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.3",
  git ? { },
}:
let
  versions = {
    "1.6.3" = import ./1.6.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pkg-config: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pkg-config: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
