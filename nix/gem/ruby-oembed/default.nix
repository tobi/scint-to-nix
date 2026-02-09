#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-oembed
#
# Available versions:
#   0.18.1
#
# Usage:
#   ruby-oembed { version = "0.18.1"; }
#   ruby-oembed { }  # latest (0.18.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.1",
  git ? { },
}:
let
  versions = {
    "0.18.1" = import ./0.18.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-oembed: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-oembed: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
