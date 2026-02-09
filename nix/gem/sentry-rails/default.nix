#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sentry-rails
#
# Available versions:
#   5.19.0
#   6.1.2
#   6.2.0
#   6.3.0
#
# Usage:
#   sentry-rails { version = "6.3.0"; }
#   sentry-rails { }  # latest (6.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.3.0",
  git ? { },
}:
let
  versions = {
    "5.19.0" = import ./5.19.0 { inherit lib stdenv ruby; };
    "6.1.2" = import ./6.1.2 { inherit lib stdenv ruby; };
    "6.2.0" = import ./6.2.0 { inherit lib stdenv ruby; };
    "6.3.0" = import ./6.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sentry-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sentry-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
