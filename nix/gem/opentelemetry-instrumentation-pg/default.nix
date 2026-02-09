#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-pg
#
# Available versions:
#   0.35.0
#
# Usage:
#   opentelemetry-instrumentation-pg { version = "0.35.0"; }
#   opentelemetry-instrumentation-pg { }  # latest (0.35.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.35.0",
  git ? { },
}:
let
  versions = {
    "0.35.0" = import ./0.35.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-pg: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-pg: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
