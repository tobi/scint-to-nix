#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-http_client
#
# Available versions:
#   0.27.0
#
# Usage:
#   opentelemetry-instrumentation-http_client { version = "0.27.0"; }
#   opentelemetry-instrumentation-http_client { }  # latest (0.27.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.27.0",
  git ? { },
}:
let
  versions = {
    "0.27.0" = import ./0.27.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-http_client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-http_client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
