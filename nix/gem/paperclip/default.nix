#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# paperclip
#
# Available versions:
#   5.3.0
#   6.0.0
#   6.1.0
#
# Usage:
#   paperclip { version = "6.1.0"; }
#   paperclip { }  # latest (6.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.1.0",
  git ? { },
}:
let
  versions = {
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "paperclip: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "paperclip: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
