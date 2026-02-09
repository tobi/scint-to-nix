#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# w3c_validators
#
# Available versions:
#   1.3.7
#
# Usage:
#   w3c_validators { version = "1.3.7"; }
#   w3c_validators { }  # latest (1.3.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.7",
  git ? { },
}:
let
  versions = {
    "1.3.7" = import ./1.3.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "w3c_validators: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "w3c_validators: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
