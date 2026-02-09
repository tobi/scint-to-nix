#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-fileupload-rails
#
# Available versions:
#   0.4.7
#
# Usage:
#   jquery-fileupload-rails { version = "0.4.7"; }
#   jquery-fileupload-rails { }  # latest (0.4.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.7",
  git ? { },
}:
let
  versions = {
    "0.4.7" = import ./0.4.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jquery-fileupload-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jquery-fileupload-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
