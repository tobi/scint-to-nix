#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validate_email
#
# Available versions:
#   0.1.6
#
# Usage:
#   validate_email { version = "0.1.6"; }
#   validate_email { }  # latest (0.1.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.6",
  git ? { },
}:
let
  versions = {
    "0.1.6" = import ./0.1.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "validate_email: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "validate_email: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
