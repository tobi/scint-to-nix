#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# emoji_regex
#
# Available versions:
#   3.2.3
#   14.0.0
#   15.0.0
#
# Usage:
#   emoji_regex { version = "15.0.0"; }
#   emoji_regex { }  # latest (15.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "15.0.0",
  git ? { },
}:
let
  versions = {
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
    "14.0.0" = import ./14.0.0 { inherit lib stdenv ruby; };
    "15.0.0" = import ./15.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "emoji_regex: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "emoji_regex: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
