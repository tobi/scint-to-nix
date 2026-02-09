#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tinymce-rails
#
# Available versions:
#   6.8.6.1
#
# Usage:
#   tinymce-rails { version = "6.8.6.1"; }
#   tinymce-rails { }  # latest (6.8.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.8.6.1",
  git ? { },
}:
let
  versions = {
    "6.8.6.1" = import ./6.8.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tinymce-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tinymce-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
