#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoon
#
# Available versions:
#   1.2.15
#
# Usage:
#   cocoon { version = "1.2.15"; }
#   cocoon { }  # latest (1.2.15)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.15",
  git ? { },
}:
let
  versions = {
    "1.2.15" = import ./1.2.15 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoon: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cocoon: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
