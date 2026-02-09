#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jruby-openssl
#
# Available versions:
#   0.9.4
#
# Usage:
#   jruby-openssl { version = "0.9.4"; }
#   jruby-openssl { }  # latest (0.9.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.4",
  git ? { },
}:
let
  versions = {
    "0.9.4" = import ./0.9.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jruby-openssl: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jruby-openssl: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
