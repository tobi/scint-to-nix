#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yard-activesupport-concern
#
# Available versions:
#   0.0.1
#
# Usage:
#   yard-activesupport-concern { version = "0.0.1"; }
#   yard-activesupport-concern { }  # latest (0.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.1",
  git ? { },
}:
let
  versions = {
    "0.0.1" = import ./0.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "yard-activesupport-concern: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "yard-activesupport-concern: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
