#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-mocks
#
# Available versions:
#   3.12.7
#   3.13.1
#   3.13.5
#   3.13.6
#   3.13.7
#
# Usage:
#   rspec-mocks { version = "3.13.7"; }
#   rspec-mocks { }  # latest (3.13.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.7",
  git ? { },
}:
let
  versions = {
    "3.12.7" = import ./3.12.7 { inherit lib stdenv ruby; };
    "3.13.1" = import ./3.13.1 { inherit lib stdenv ruby; };
    "3.13.5" = import ./3.13.5 { inherit lib stdenv ruby; };
    "3.13.6" = import ./3.13.6 { inherit lib stdenv ruby; };
    "3.13.7" = import ./3.13.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-mocks: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rspec-mocks: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
