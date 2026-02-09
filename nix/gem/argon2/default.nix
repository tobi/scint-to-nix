#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# argon2
#
# Available versions:
#   2.3.2
#
# Usage:
#   argon2 { version = "2.3.2"; }
#   argon2 { }  # latest (2.3.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.2",
  git ? { },
}:
let
  versions = {
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "argon2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "argon2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
