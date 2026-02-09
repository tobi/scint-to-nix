#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-output-statsd
#
# Available versions:
#   3.1.4
#   3.1.5
#   3.2.0
#
# Usage:
#   logstash-output-statsd { version = "3.2.0"; }
#   logstash-output-statsd { }  # latest (3.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.0",
  git ? { },
}:
let
  versions = {
    "3.1.4" = import ./3.1.4 { inherit lib stdenv ruby; };
    "3.1.5" = import ./3.1.5 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logstash-output-statsd: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "logstash-output-statsd: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
