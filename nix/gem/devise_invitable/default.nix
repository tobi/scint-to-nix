#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_invitable
#
# Available versions:
#   2.0.9
#
# Usage:
#   devise_invitable { version = "2.0.9"; }
#   devise_invitable { }  # latest (2.0.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.9",
  git ? { },
}:
let
  versions = {
    "2.0.9" = import ./2.0.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "devise_invitable: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "devise_invitable: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
