#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-aliyun
#
# Available versions:
#   0.3.18
#   0.3.19
#   0.4.0
#
# Usage:
#   fog-aliyun { version = "0.4.0"; }
#   fog-aliyun { }  # latest (0.4.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.0",
  git ? { },
}:
let
  versions = {
    "0.3.18" = import ./0.3.18 { inherit lib stdenv ruby; };
    "0.3.19" = import ./0.3.19 { inherit lib stdenv ruby; };
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-aliyun: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fog-aliyun: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
