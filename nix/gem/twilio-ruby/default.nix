#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twilio-ruby
#
# Available versions:
#   7.6.0
#   7.9.1
#   7.10.0
#   7.10.1
#
# Usage:
#   twilio-ruby { version = "7.10.1"; }
#   twilio-ruby { }  # latest (7.10.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.10.1",
  git ? { },
}:
let
  versions = {
    "7.6.0" = import ./7.6.0 { inherit lib stdenv ruby; };
    "7.9.1" = import ./7.9.1 { inherit lib stdenv ruby; };
    "7.10.0" = import ./7.10.0 { inherit lib stdenv ruby; };
    "7.10.1" = import ./7.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "twilio-ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "twilio-ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
