#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gitlab-labkit
#
# Available versions:
#   1.3.2
#   1.3.3
#   1.3.4
#
# Usage:
#   gitlab-labkit { version = "1.3.4"; }
#   gitlab-labkit { }  # latest (1.3.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.4",
  git ? { },
}:
let
  versions = {
    "1.3.2" = import ./1.3.2 { inherit lib stdenv ruby; };
    "1.3.3" = import ./1.3.3 { inherit lib stdenv ruby; };
    "1.3.4" = import ./1.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gitlab-labkit: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gitlab-labkit: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
