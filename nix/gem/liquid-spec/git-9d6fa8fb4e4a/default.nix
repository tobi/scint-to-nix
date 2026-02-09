#
# ╔═══════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/import to refresh ║
# ╚═══════════════════════════════════════════════════════╝
#
# Git: liquid-spec @ 9d6fa8fb4e4a
# URI: https://github.com/Shopify/liquid-spec.git
# Gems: liquid-spec
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "liquid-spec";
  version = "9d6fa8fb4e4a";
  src = builtins.path {
    path = ./source;
    name = "liquid-spec-9d6fa8fb4e4a-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}/bundler/gems/liquid-spec-9d6fa8fb4e4a
    mkdir -p $dest
    cp -r . $dest/
  '';
}
