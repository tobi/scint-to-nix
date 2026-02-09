#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# delayed_job
#
# Available versions:
#   4.1.12
#   4.1.13
#   4.2.0
#
# Usage:
#   delayed_job { version = "4.2.0"; }
#   delayed_job { }  # latest (4.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.0",
  git ? { },
}:
let
  versions = {
    "4.1.12" = import ./4.1.12 { inherit lib stdenv ruby; };
    "4.1.13" = import ./4.1.13 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "delayed_job: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "delayed_job: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
