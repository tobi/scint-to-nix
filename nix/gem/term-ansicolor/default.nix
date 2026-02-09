#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# term-ansicolor
#
# Available versions:
#   1.11.1
#   1.11.2
#   1.11.3
#
# Usage:
#   term-ansicolor { version = "1.11.3"; }
#   term-ansicolor { }  # latest (1.11.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.3",
  git ? { },
}:
let
  versions = {
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
    "1.11.2" = import ./1.11.2 { inherit lib stdenv ruby; };
    "1.11.3" = import ./1.11.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "term-ansicolor: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "term-ansicolor: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
