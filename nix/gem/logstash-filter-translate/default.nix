#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-filter-translate
#
# Available versions:
#   3.4.2
#   3.4.3
#   3.5.0
#
# Usage:
#   logstash-filter-translate { version = "3.5.0"; }
#   logstash-filter-translate { }  # latest (3.5.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.0",
  git ? { },
}:
let
  versions = {
    "3.4.2" = import ./3.4.2 { inherit lib stdenv ruby; };
    "3.4.3" = import ./3.4.3 { inherit lib stdenv ruby; };
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logstash-filter-translate: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "logstash-filter-translate: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
