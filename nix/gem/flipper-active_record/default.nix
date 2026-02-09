#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper-active_record
#
# Available versions:
#   0.25.4
#   1.3.4
#   1.3.5
#   1.3.6
#
# Usage:
#   flipper-active_record { version = "1.3.6"; }
#   flipper-active_record { }  # latest (1.3.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.6",
  git ? { },
}:
let
  versions = {
    "0.25.4" = import ./0.25.4 { inherit lib stdenv ruby; };
    "1.3.4" = import ./1.3.4 { inherit lib stdenv ruby; };
    "1.3.5" = import ./1.3.5 { inherit lib stdenv ruby; };
    "1.3.6" = import ./1.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flipper-active_record: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "flipper-active_record: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
