#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq-cron
#
# Available versions:
#   1.12.0
#   2.2.0
#   2.3.0
#   2.3.1
#
# Usage:
#   sidekiq-cron { version = "2.3.1"; }
#   sidekiq-cron { }  # latest (2.3.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.1",
  git ? { },
}:
let
  versions = {
    "1.12.0" = import ./1.12.0 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.3.1" = import ./2.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sidekiq-cron: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sidekiq-cron: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
