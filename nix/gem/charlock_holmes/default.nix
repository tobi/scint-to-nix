#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# charlock_holmes
#
# Available versions:
#   0.7.7
#   0.7.8
#   0.7.9
#
# Usage:
#   charlock_holmes { version = "0.7.9"; }
#   charlock_holmes { }  # latest (0.7.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.9",
  git ? { },
}:
let
  versions = {
    "0.7.7" = import ./0.7.7 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "0.7.8" = import ./0.7.8 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "0.7.9" = import ./0.7.9 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "charlock_holmes: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "charlock_holmes: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
