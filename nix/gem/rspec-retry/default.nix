#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-retry
#
# Available versions:
#   0.6.0
#   0.6.1
#   0.6.2
#
# Usage:
#   rspec-retry { version = "0.6.2"; }
#   rspec-retry { }  # latest (0.6.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.2",
  git ? { },
}:
let
  versions = {
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
    "0.6.2" = import ./0.6.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-retry: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rspec-retry: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
