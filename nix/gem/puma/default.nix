#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# puma
#
# Available versions:
#   5.6.9
#   6.4.3
#   6.5.0
#   7.0.0.pre1
#   7.0.4
#   7.1.0
#   7.2.0
#
# Usage:
#   puma { version = "7.2.0"; }
#   puma { }  # latest (7.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.2.0",
  git ? { },
}:
let
  versions = {
    "5.6.9" = import ./5.6.9 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "6.4.3" = import ./6.4.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "6.5.0" = import ./6.5.0 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "7.0.0.pre1" = import ./7.0.0.pre1 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "7.0.4" = import ./7.0.4 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "7.1.0" = import ./7.1.0 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "7.2.0" = import ./7.2.0 {
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
    or (throw "puma: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "puma: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
