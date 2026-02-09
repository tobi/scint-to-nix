#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stripe-ruby-mock
#
# Available versions:
#   3.1.0.rc3
#
# Usage:
#   stripe-ruby-mock { version = "3.1.0.rc3"; }
#   stripe-ruby-mock { }  # latest (3.1.0.rc3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.0.rc3",
  git ? { },
}:
let
  versions = {
    "3.1.0.rc3" = import ./3.1.0.rc3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stripe-ruby-mock: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "stripe-ruby-mock: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
