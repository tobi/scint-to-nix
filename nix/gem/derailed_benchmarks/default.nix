#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# derailed_benchmarks
#
# Available versions:
#   2.1.2
#   2.2.0
#   2.2.1
#
# Usage:
#   derailed_benchmarks { version = "2.2.1"; }
#   derailed_benchmarks { }  # latest (2.2.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.1",
  git ? { },
}:
let
  versions = {
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "derailed_benchmarks: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "derailed_benchmarks: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
