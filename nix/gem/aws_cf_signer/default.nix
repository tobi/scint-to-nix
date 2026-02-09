#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws_cf_signer
#
# Available versions:
#   0.1.3
#
# Usage:
#   aws_cf_signer { version = "0.1.3"; }
#   aws_cf_signer { }  # latest (0.1.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.3",
  git ? { },
}:
let
  versions = {
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws_cf_signer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws_cf_signer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
