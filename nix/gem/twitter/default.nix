#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twitter
#
# Available versions:
#   7.0.0
#
# Usage:
#   twitter { version = "7.0.0"; }
#   twitter { }  # latest (7.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.0",
  git ? { },
}:
let
  versions = {
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "twitter: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "twitter: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
