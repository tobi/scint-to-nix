#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# awesome_nested_set
#
# Available versions:
#   3.9.0
#
# Usage:
#   awesome_nested_set { version = "3.9.0"; }
#   awesome_nested_set { }  # latest (3.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.0",
  git ? { },
}:
let
  versions = {
    "3.9.0" = import ./3.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "awesome_nested_set: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "awesome_nested_set: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
