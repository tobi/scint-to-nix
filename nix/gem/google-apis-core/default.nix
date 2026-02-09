#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-core
#
# Available versions:
#   0.15.1
#   1.0.0
#   1.0.1
#   1.0.2
#
# Usage:
#   google-apis-core { version = "1.0.2"; }
#   google-apis-core { }  # latest (1.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.2",
  git ? { },
}:
let
  versions = {
    "0.15.1" = import ./0.15.1 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-apis-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
