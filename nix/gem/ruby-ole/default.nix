#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-ole
#
# Available versions:
#   1.2.12.2
#   1.2.13
#   1.2.13.1
#
# Usage:
#   ruby-ole { version = "1.2.13.1"; }
#   ruby-ole { }  # latest (1.2.13.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.13.1",
  git ? { },
}:
let
  versions = {
    "1.2.12.2" = import ./1.2.12.2 { inherit lib stdenv ruby; };
    "1.2.13" = import ./1.2.13 { inherit lib stdenv ruby; };
    "1.2.13.1" = import ./1.2.13.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-ole: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-ole: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
