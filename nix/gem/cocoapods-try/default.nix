#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-try
#
# Available versions:
#   1.0.0
#   1.1.0
#   1.2.0
#
# Usage:
#   cocoapods-try { version = "1.2.0"; }
#   cocoapods-try { }  # latest (1.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.0",
  git ? { },
}:
let
  versions = {
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoapods-try: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cocoapods-try: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
