#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ddtrace
#
# Available versions:
#   1.16.2
#   1.23.1
#   1.23.2
#   1.23.3
#
# Usage:
#   ddtrace { version = "1.23.3"; }
#   ddtrace { }  # latest (1.23.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.23.3",
  git ? { },
}:
let
  versions = {
    "1.16.2" = import ./1.16.2 { inherit lib stdenv ruby; };
    "1.23.1" = import ./1.23.1 { inherit lib stdenv ruby; };
    "1.23.2" = import ./1.23.2 { inherit lib stdenv ruby; };
    "1.23.3" = import ./1.23.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ddtrace: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ddtrace: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
