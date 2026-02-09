#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot_rails
#
# Available versions:
#   6.2.0
#   6.4.3
#   6.4.4
#   6.5.0
#   6.5.1
#
# Usage:
#   factory_bot_rails { version = "6.5.1"; }
#   factory_bot_rails { }  # latest (6.5.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.5.1",
  git ? { },
}:
let
  versions = {
    "6.2.0" = import ./6.2.0 { inherit lib stdenv ruby; };
    "6.4.3" = import ./6.4.3 { inherit lib stdenv ruby; };
    "6.4.4" = import ./6.4.4 { inherit lib stdenv ruby; };
    "6.5.0" = import ./6.5.0 { inherit lib stdenv ruby; };
    "6.5.1" = import ./6.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_bot_rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "factory_bot_rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
