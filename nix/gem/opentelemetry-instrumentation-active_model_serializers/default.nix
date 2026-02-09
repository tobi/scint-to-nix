#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_model_serializers
#
# Available versions:
#   0.24.0
#
# Usage:
#   opentelemetry-instrumentation-active_model_serializers { version = "0.24.0"; }
#   opentelemetry-instrumentation-active_model_serializers { }  # latest (0.24.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.24.0",
  git ? { },
}:
let
  versions = {
    "0.24.0" = import ./0.24.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-active_model_serializers: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-active_model_serializers: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
