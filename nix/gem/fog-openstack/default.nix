#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-openstack
#
# Available versions:
#   1.1.5
#
# Usage:
#   fog-openstack { version = "1.1.5"; }
#   fog-openstack { }  # latest (1.1.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.5",
  git ? { },
}:
let
  versions = {
    "1.1.5" = import ./1.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-openstack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fog-openstack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
