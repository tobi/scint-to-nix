#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# amq-protocol
#
# Available versions:
#   2.3.2
#   2.4.0
#   2.5.0
#   2.5.1
#
# Usage:
#   amq-protocol { version = "2.5.1"; }
#   amq-protocol { }  # latest (2.5.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.1",
  git ? { },
}:
let
  versions = {
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "amq-protocol: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "amq-protocol: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
