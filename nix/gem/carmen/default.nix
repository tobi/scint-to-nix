#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# carmen
#
# Available versions:
#   1.1.3
#
# Usage:
#   carmen { version = "1.1.3"; }
#   carmen { }  # latest (1.1.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.3",
  git ? { },
}:
let
  versions = {
    "1.1.3" = import ./1.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "carmen: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "carmen: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
