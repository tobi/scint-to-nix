#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-dsl
#
# Available versions:
#   0.1.10
#
# Usage:
#   elasticsearch-dsl { version = "0.1.10"; }
#   elasticsearch-dsl { }  # latest (0.1.10)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.10",
  git ? { },
}:
let
  versions = {
    "0.1.10" = import ./0.1.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elasticsearch-dsl: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "elasticsearch-dsl: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
