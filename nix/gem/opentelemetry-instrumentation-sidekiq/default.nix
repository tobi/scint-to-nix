#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-sidekiq
#
# Available versions:
#   0.28.1
#
# Usage:
#   opentelemetry-instrumentation-sidekiq { version = "0.28.1"; }
#   opentelemetry-instrumentation-sidekiq { }  # latest (0.28.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.28.1",
  git ? { },
}:
let
  versions = {
    "0.28.1" = import ./0.28.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-sidekiq: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-sidekiq: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
