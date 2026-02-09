#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-vips
#
# Available versions:
#   2.1.4
#   2.2.1
#   2.2.2
#   2.2.4
#   2.2.5
#   2.3.0
#
# Usage:
#   ruby-vips { version = "2.3.0"; }
#   ruby-vips { }  # latest (2.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.0",
  git ? { },
}:
let
  versions = {
    "2.1.4" = import ./2.1.4 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.2.2" = import ./2.2.2 { inherit lib stdenv ruby; };
    "2.2.4" = import ./2.2.4 { inherit lib stdenv ruby; };
    "2.2.5" = import ./2.2.5 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-vips: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-vips: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
