#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pagy
#
# Available versions:
#   43.2.9
#
# Usage:
#   pagy { version = "43.2.9"; }
#   pagy { }  # latest (43.2.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "43.2.9",
  git ? { },
}:
let
  versions = {
    "43.2.9" = import ./43.2.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pagy: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pagy: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
