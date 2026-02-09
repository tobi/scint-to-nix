#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email_validator
#
# Available versions:
#   2.2.4
#
# Usage:
#   email_validator { version = "2.2.4"; }
#   email_validator { }  # latest (2.2.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.4",
  git ? { },
}:
let
  versions = {
    "2.2.4" = import ./2.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "email_validator: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "email_validator: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
