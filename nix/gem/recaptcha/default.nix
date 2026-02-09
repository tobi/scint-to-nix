#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# recaptcha
#
# Available versions:
#   5.16.0
#   5.20.1
#   5.21.0
#   5.21.1
#
# Usage:
#   recaptcha { version = "5.21.1"; }
#   recaptcha { }  # latest (5.21.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.21.1",
  git ? { },
}:
let
  versions = {
    "5.16.0" = import ./5.16.0 { inherit lib stdenv ruby; };
    "5.20.1" = import ./5.20.1 { inherit lib stdenv ruby; };
    "5.21.0" = import ./5.21.0 { inherit lib stdenv ruby; };
    "5.21.1" = import ./5.21.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "recaptcha: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "recaptcha: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
