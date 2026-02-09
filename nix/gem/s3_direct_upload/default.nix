#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# s3_direct_upload
#
# Available versions:
#   0.1.7
#
# Usage:
#   s3_direct_upload { version = "0.1.7"; }
#   s3_direct_upload { }  # latest (0.1.7)
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
    "0.1.7" = import ./0.1.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "s3_direct_upload: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "s3_direct_upload: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
