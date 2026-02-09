#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libxml-ruby
#
# Available versions:
#   5.0.4
#
# Usage:
#   libxml-ruby { version = "5.0.4"; }
#   libxml-ruby { }  # latest (5.0.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.4",
  git ? { },
}:
let
  versions = {
    "5.0.4" = import ./5.0.4 {
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
    or (throw "libxml-ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "libxml-ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
