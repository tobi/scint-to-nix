#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# any_ascii
#
# Available versions:
#   0.3.3
#
# Usage:
#   any_ascii { version = "0.3.3"; }
#   any_ascii { }  # latest (0.3.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.3",
  git ? { },
}:
let
  versions = {
    "0.3.3" = import ./0.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "any_ascii: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "any_ascii: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
