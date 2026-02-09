#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-action_mailer
#
# Available versions:
#   0.6.1
#
# Usage:
#   opentelemetry-instrumentation-action_mailer { version = "0.6.1"; }
#   opentelemetry-instrumentation-action_mailer { }  # latest (0.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.1",
  git ? { },
}:
let
  versions = {
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-action_mailer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-action_mailer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
