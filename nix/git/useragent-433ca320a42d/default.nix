# Git: useragent @ 433ca320a42d
# URI: https://github.com/basecamp/useragent
# Gems: useragent
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "useragent";
  version = "433ca320a42d";
  src = builtins.path { path = ./source; name = "useragent-433ca320a42d-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}/bundler/gems/useragent-433ca320a42d
    mkdir -p $dest
    cp -r . $dest/
  '';
}
