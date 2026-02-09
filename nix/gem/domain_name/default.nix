#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# domain_name
#
# Available versions:
#   0.5.20190701
#   0.6.20231109
#   0.6.20240107
#
# Usage:
#   domain_name { version = "0.6.20240107"; }
#   domain_name { }  # latest (0.6.20240107)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.20240107",
  git ? { },
}:
let
  versions = {
    "0.5.20190701" = import ./0.5.20190701 { inherit lib stdenv ruby; };
    "0.6.20231109" = import ./0.6.20231109 { inherit lib stdenv ruby; };
    "0.6.20240107" = import ./0.6.20240107 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "domain_name: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "domain_name: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
