#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# acts_as_list
#
# Available versions:
#   1.2.4
#   1.2.5
#   1.2.6
#
# Usage:
#   acts_as_list { version = "1.2.6"; }
#   acts_as_list { }  # latest (1.2.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.6",
  git ? { },
}:
let
  versions = {
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
    "1.2.6" = import ./1.2.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "acts_as_list: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "acts_as_list: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
