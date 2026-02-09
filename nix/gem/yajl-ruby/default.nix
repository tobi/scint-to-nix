#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yajl-ruby
#
# Available versions:
#   1.4.1
#   1.4.2
#   1.4.3
#
# Usage:
#   yajl-ruby { version = "1.4.3"; }
#   yajl-ruby { }  # latest (1.4.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.3",
  git ? { },
}:
let
  versions = {
    "1.4.1" = import ./1.4.1 { inherit lib stdenv ruby; };
    "1.4.2" = import ./1.4.2 { inherit lib stdenv ruby; };
    "1.4.3" = import ./1.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "yajl-ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "yajl-ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
