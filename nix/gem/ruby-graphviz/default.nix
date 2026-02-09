#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-graphviz
#
# Available versions:
#   1.2.3
#   1.2.4
#   1.2.5
#
# Usage:
#   ruby-graphviz { version = "1.2.5"; }
#   ruby-graphviz { }  # latest (1.2.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.5",
  git ? { },
}:
let
  versions = {
    "1.2.3" = import ./1.2.3 { inherit lib stdenv ruby; };
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-graphviz: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-graphviz: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
