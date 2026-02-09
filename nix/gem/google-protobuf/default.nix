#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-protobuf
#
# Available versions:
#   3.25.5
#   3.25.7
#   4.29.3
#   4.33.2
#   4.33.3
#   4.33.4
#   4.33.5
#
# Usage:
#   google-protobuf { version = "4.33.5"; }
#   google-protobuf { }  # latest (4.33.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.33.5",
  git ? { },
}:
let
  versions = {
    "3.25.5" = import ./3.25.5 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "3.25.7" = import ./3.25.7 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "4.29.3" = import ./4.29.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "4.33.2" = import ./4.33.2 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "4.33.3" = import ./4.33.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "4.33.4" = import ./4.33.4 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "4.33.5" = import ./4.33.5 {
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
    or (throw "google-protobuf: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-protobuf: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
