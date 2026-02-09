#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bouncy-castle-java
#
# Available versions:
#   1.5.0147
#
# Usage:
#   bouncy-castle-java { version = "1.5.0147"; }
#   bouncy-castle-java { }  # latest (1.5.0147)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.5.0147",
  git ? { },
}:
let
  versions = {
    "1.5.0147" = import ./1.5.0147 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bouncy-castle-java: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bouncy-castle-java: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
