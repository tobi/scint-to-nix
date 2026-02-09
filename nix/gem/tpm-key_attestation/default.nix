#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tpm-key_attestation
#
# Available versions:
#   0.14.1
#
# Usage:
#   tpm-key_attestation { version = "0.14.1"; }
#   tpm-key_attestation { }  # latest (0.14.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.14.1",
  git ? { },
}:
let
  versions = {
    "0.14.1" = import ./0.14.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tpm-key_attestation: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tpm-key_attestation: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
