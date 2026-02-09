#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# azure-blob
#
# Available versions:
#   0.5.9.1
#
# Usage:
#   azure-blob { version = "0.5.9.1"; }
#   azure-blob { }  # latest (0.5.9.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.9.1",
  git ? { },
}:
let
  versions = {
    "0.5.9.1" = import ./0.5.9.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "azure-blob: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "azure-blob: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
