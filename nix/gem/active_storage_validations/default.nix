#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_storage_validations
#
# Available versions:
#   1.3.0
#
# Usage:
#   active_storage_validations { version = "1.3.0"; }
#   active_storage_validations { }  # latest (1.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.0",
  git ? { },
}:
let
  versions = {
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "active_storage_validations: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "active_storage_validations: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
