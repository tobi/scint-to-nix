#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sorbet-runtime
#
# Available versions:
#   0.5.11934
#   0.6.12915
#   0.6.12925
#   0.6.12929
#
# Usage:
#   sorbet-runtime { version = "0.6.12929"; }
#   sorbet-runtime { }  # latest (0.6.12929)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.12929",
  git ? { },
}:
let
  versions = {
    "0.5.11934" = import ./0.5.11934 { inherit lib stdenv ruby; };
    "0.6.12915" = import ./0.6.12915 { inherit lib stdenv ruby; };
    "0.6.12925" = import ./0.6.12925 { inherit lib stdenv ruby; };
    "0.6.12929" = import ./0.6.12929 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sorbet-runtime: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sorbet-runtime: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
