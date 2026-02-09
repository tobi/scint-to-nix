#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bcp47_spec
#
# Available versions:
#   0.2.1
#
# Usage:
#   bcp47_spec { version = "0.2.1"; }
#   bcp47_spec { }  # latest (0.2.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.1",
  git ? { },
}:
let
  versions = {
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bcp47_spec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bcp47_spec: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
