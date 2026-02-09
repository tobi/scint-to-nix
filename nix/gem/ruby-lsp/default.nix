#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp
#
# Available versions:
#   0.26.4
#   0.26.5
#
# Usage:
#   ruby-lsp { version = "0.26.5"; }
#   ruby-lsp { }  # latest (0.26.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.5",
  git ? { },
}:
let
  versions = {
    "0.26.4" = import ./0.26.4 { inherit lib stdenv ruby; };
    "0.26.5" = import ./0.26.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-lsp: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-lsp: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
