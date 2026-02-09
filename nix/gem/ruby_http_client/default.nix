#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_http_client
#
# Available versions:
#   3.5.4
#   3.5.5
#   3.6.0
#
# Usage:
#   ruby_http_client { version = "3.6.0"; }
#   ruby_http_client { }  # latest (3.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.6.0",
  git ? { },
}:
let
  versions = {
    "3.5.4" = import ./3.5.4 { inherit lib stdenv ruby; };
    "3.5.5" = import ./3.5.5 { inherit lib stdenv ruby; };
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby_http_client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby_http_client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
