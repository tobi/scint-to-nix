#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleauth
#
# Available versions:
#   1.11.2
#   1.12.2
#   1.15.1
#   1.16.0
#   1.16.1
#
# Usage:
#   googleauth { version = "1.16.1"; }
#   googleauth { }  # latest (1.16.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.16.1",
  git ? { },
}:
let
  versions = {
    "1.11.2" = import ./1.11.2 { inherit lib stdenv ruby; };
    "1.12.2" = import ./1.12.2 { inherit lib stdenv ruby; };
    "1.15.1" = import ./1.15.1 { inherit lib stdenv ruby; };
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.16.1" = import ./1.16.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "googleauth: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "googleauth: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
