#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-faraday
#
# Available versions:
#   0.31.0
#
# Usage:
#   opentelemetry-instrumentation-faraday { version = "0.31.0"; }
#   opentelemetry-instrumentation-faraday { }  # latest (0.31.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.31.0",
  git ? { },
}:
let
  versions = {
    "0.31.0" = import ./0.31.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-faraday: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-faraday: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
