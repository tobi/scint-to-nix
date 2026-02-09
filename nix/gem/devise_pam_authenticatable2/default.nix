#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_pam_authenticatable2
#
# Available versions:
#   9.2.0
#
# Usage:
#   devise_pam_authenticatable2 { version = "9.2.0"; }
#   devise_pam_authenticatable2 { }  # latest (9.2.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.2.0",
  git ? { },
}:
let
  versions = {
    "9.2.0" = import ./9.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "devise_pam_authenticatable2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "devise_pam_authenticatable2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
