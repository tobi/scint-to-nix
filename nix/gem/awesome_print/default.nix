#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# awesome_print
#
# Available versions:
#   1.7.0
#   1.8.0
#   1.9.2
#   2.0.0.pre2
#
# Usage:
#   awesome_print { version = "2.0.0.pre2"; }
#   awesome_print { }  # latest (2.0.0.pre2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0.pre2",
  git ? { },
}:
let
  versions = {
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.9.2" = import ./1.9.2 { inherit lib stdenv ruby; };
    "2.0.0.pre2" = import ./2.0.0.pre2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "awesome_print: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "awesome_print: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
