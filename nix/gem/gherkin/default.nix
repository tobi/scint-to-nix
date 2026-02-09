#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gherkin
#
# Available versions:
#   8.2.0
#   8.2.1
#   9.0.0
#
# Usage:
#   gherkin { version = "9.0.0"; }
#   gherkin { }  # latest (9.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.0.0",
  git ? { },
}:
let
  versions = {
    "8.2.0" = import ./8.2.0 { inherit lib stdenv ruby; };
    "8.2.1" = import ./8.2.1 { inherit lib stdenv ruby; };
    "9.0.0" = import ./9.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gherkin: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gherkin: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
