#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-io
#
# Available versions:
#   0.17.1
#   0.17.2
#   0.17.3
#
# Usage:
#   celluloid-io { version = "0.17.3"; }
#   celluloid-io { }  # latest (0.17.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.17.3",
  git ? { },
}:
let
  versions = {
    "0.17.1" = import ./0.17.1 { inherit lib stdenv ruby; };
    "0.17.2" = import ./0.17.2 { inherit lib stdenv ruby; };
    "0.17.3" = import ./0.17.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "celluloid-io: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "celluloid-io: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
