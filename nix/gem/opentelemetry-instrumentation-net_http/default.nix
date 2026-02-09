#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-net_http
#
# Available versions:
#   0.27.0
#
# Usage:
#   opentelemetry-instrumentation-net_http { version = "0.27.0"; }
#   opentelemetry-instrumentation-net_http { }  # latest (0.27.0)
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
    or (throw "opentelemetry-instrumentation-net_http: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-net_http: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
