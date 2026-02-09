#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-redis
#
# Available versions:
#   0.28.0
#
# Usage:
#   opentelemetry-instrumentation-redis { version = "0.28.0"; }
#   opentelemetry-instrumentation-redis { }  # latest (0.28.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.28.0",
  git ? { },
}:
let
  versions = {
    "0.28.0" = import ./0.28.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-redis: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-redis: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
