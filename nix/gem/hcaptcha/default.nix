#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hcaptcha
#
# Available versions:
#   7.1.0
#
# Usage:
#   hcaptcha { version = "7.1.0"; }
#   hcaptcha { }  # latest (7.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.0",
  git ? { },
}:
let
  versions = {
    "7.1.0" = import ./7.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hcaptcha: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "hcaptcha: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
