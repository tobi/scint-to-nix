#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-rails
#
# Available versions:
#   0.39.1
#
# Usage:
#   opentelemetry-instrumentation-rails { version = "0.39.1"; }
#   opentelemetry-instrumentation-rails { }  # latest (0.39.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.39.1",
  git ? { },
}:
let
  versions = {
    "0.39.1" = import ./0.39.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
