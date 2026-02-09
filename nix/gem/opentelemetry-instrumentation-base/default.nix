#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-base
#
# Available versions:
#   0.25.0
#
# Usage:
#   opentelemetry-instrumentation-base { version = "0.25.0"; }
#   opentelemetry-instrumentation-base { }  # latest (0.25.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.25.0",
  git ? { },
}:
let
  versions = {
    "0.25.0" = import ./0.25.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-base: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-base: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
