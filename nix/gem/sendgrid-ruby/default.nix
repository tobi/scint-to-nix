#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sendgrid-ruby
#
# Available versions:
#   6.6.1
#   6.6.2
#   6.7.0
#
# Usage:
#   sendgrid-ruby { version = "6.7.0"; }
#   sendgrid-ruby { }  # latest (6.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.7.0",
  git ? { },
}:
let
  versions = {
    "6.6.1" = import ./6.6.1 { inherit lib stdenv ruby; };
    "6.6.2" = import ./6.6.2 { inherit lib stdenv ruby; };
    "6.7.0" = import ./6.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sendgrid-ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sendgrid-ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
