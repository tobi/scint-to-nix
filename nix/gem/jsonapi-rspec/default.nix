#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsonapi-rspec
#
# Available versions:
#   0.0.11
#
# Usage:
#   jsonapi-rspec { version = "0.0.11"; }
#   jsonapi-rspec { }  # latest (0.0.11)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.11",
  git ? { },
}:
let
  versions = {
    "0.0.11" = import ./0.0.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jsonapi-rspec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jsonapi-rspec: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
