#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-next-core
#
# Available versions:
#   0.15.2
#
# Usage:
#   ruby-next-core { version = "0.15.2"; }
#   ruby-next-core { }  # latest (0.15.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.2",
  git ? { },
}:
let
  versions = {
    "0.15.2" = import ./0.15.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-next-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-next-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
