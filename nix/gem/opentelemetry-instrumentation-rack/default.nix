#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-rack
#
# Available versions:
#   0.29.0
#
# Usage:
#   opentelemetry-instrumentation-rack { version = "0.29.0"; }
#   opentelemetry-instrumentation-rack { }  # latest (0.29.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.29.0",
  git ? { },
}:
let
  versions = {
    "0.29.0" = import ./0.29.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-rack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-rack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
