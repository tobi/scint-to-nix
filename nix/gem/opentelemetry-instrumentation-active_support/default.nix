#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_support
#
# Available versions:
#   0.10.1
#
# Usage:
#   opentelemetry-instrumentation-active_support { version = "0.10.1"; }
#   opentelemetry-instrumentation-active_support { }  # latest (0.10.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.1",
  git ? { },
}:
let
  versions = {
    "0.10.1" = import ./0.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-active_support: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-active_support: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
