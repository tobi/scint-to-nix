#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http2
#
# Available versions:
#   0.18.4
#
# Usage:
#   net-http2 { version = "0.18.4"; }
#   net-http2 { }  # latest (0.18.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.4",
  git ? { },
}:
let
  versions = {
    "0.18.4" = import ./0.18.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-http2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "net-http2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
