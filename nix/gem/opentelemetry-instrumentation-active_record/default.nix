#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_record
#
# Available versions:
#   0.11.1
#
# Usage:
#   opentelemetry-instrumentation-active_record { version = "0.11.1"; }
#   opentelemetry-instrumentation-active_record { }  # latest (0.11.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.1",
  git ? { },
}:
let
  versions = {
    "0.11.1" = import ./0.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-active_record: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-active_record: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
