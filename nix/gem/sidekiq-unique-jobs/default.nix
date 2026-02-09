#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq-unique-jobs
#
# Available versions:
#   7.1.33
#   8.0.13
#
# Usage:
#   sidekiq-unique-jobs { version = "8.0.13"; }
#   sidekiq-unique-jobs { }  # latest (8.0.13)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.13",
  git ? { },
}:
let
  versions = {
    "7.1.33" = import ./7.1.33 { inherit lib stdenv ruby; };
    "8.0.13" = import ./8.0.13 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sidekiq-unique-jobs: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sidekiq-unique-jobs: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
