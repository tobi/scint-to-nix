#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-grafana-loki
#
# Available versions:
#   1.2.18
#   1.2.19
#   1.2.20
#
# Usage:
#   fluent-plugin-grafana-loki { version = "1.2.20"; }
#   fluent-plugin-grafana-loki { }  # latest (1.2.20)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.20",
  git ? { },
}:
let
  versions = {
    "1.2.18" = import ./1.2.18 { inherit lib stdenv ruby; };
    "1.2.19" = import ./1.2.19 { inherit lib stdenv ruby; };
    "1.2.20" = import ./1.2.20 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluent-plugin-grafana-loki: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fluent-plugin-grafana-loki: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
