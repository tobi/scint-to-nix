#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# teaspoon-mocha
#
# Available versions:
#   2.3.3
#
# Usage:
#   teaspoon-mocha { version = "2.3.3"; }
#   teaspoon-mocha { }  # latest (2.3.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.3",
  git ? { },
}:
let
  versions = {
    "2.3.3" = import ./2.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "teaspoon-mocha: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "teaspoon-mocha: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
