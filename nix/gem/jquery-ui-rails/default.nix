#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-ui-rails
#
# Available versions:
#   6.0.1
#   7.0.0
#   8.0.0
#
# Usage:
#   jquery-ui-rails { version = "8.0.0"; }
#   jquery-ui-rails { }  # latest (8.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.0",
  git ? { },
}:
let
  versions = {
    "6.0.1" = import ./6.0.1 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jquery-ui-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jquery-ui-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
