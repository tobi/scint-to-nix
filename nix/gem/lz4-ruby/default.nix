#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lz4-ruby
#
# Available versions:
#   0.3.3
#
# Usage:
#   lz4-ruby { version = "0.3.3"; }
#   lz4-ruby { }  # latest (0.3.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.3",
  git ? { },
}:
let
  versions = {
    "0.3.3" = import ./0.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "lz4-ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "lz4-ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
