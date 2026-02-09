#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-action_pack
#
# Available versions:
#   0.15.1
#
# Usage:
#   opentelemetry-instrumentation-action_pack { version = "0.15.1"; }
#   opentelemetry-instrumentation-action_pack { }  # latest (0.15.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.1",
  git ? { },
}:
let
  versions = {
    "0.15.1" = import ./0.15.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-action_pack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-action_pack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
