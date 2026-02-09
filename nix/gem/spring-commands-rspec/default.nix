#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring-commands-rspec
#
# Available versions:
#   1.0.2
#   1.0.3
#   1.0.4
#
# Usage:
#   spring-commands-rspec { version = "1.0.4"; }
#   spring-commands-rspec { }  # latest (1.0.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.4",
  git ? { },
}:
let
  versions = {
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
    "1.0.4" = import ./1.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "spring-commands-rspec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "spring-commands-rspec: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
