# nokogiri 1.19.0
{ lib, stdenv, ruby, pkgs }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
  overlay = import ../../../overlays/nokogiri.nix { inherit pkgs ruby; };
  overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [];
  overlayBuildPhase = if builtins.isAttrs overlay && overlay ? buildPhase then overlay.buildPhase else null;
in

stdenv.mkDerivation {
  pname = "nokogiri";
  version = "1.19.0";
  src = builtins.path { path = ./source; name = "nokogiri-1.19.0-source"; };

  nativeBuildInputs = [ ruby ] ++ overlayDeps;

  buildPhase = if overlayBuildPhase != null then overlayBuildPhase else ''
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      echo "Building extension in $dir"
      (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES)
    done
    for makefile in $(find ext -name Makefile 2>/dev/null); do
      dir=$(dirname "$makefile")
      target_name=$(sed -n 's/^TARGET = //p' "$makefile")
      target_prefix=$(sed -n 's/^target_prefix = //p' "$makefile")
      if [ -n "$target_name" ] && [ -f "$dir/$target_name.so" ]; then
        mkdir -p "lib$target_prefix"
        cp "$dir/$target_name.so" "lib$target_prefix/$target_name.so"
        echo "Installed $dir/$target_name.so -> lib$target_prefix/$target_name.so"
      fi
    done
  '';

  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/nokogiri-1.19.0
    cp -r . $dest/gems/nokogiri-1.19.0/
    # Install compiled extensions
    local extdir=$dest/extensions/${arch}/${rubyVersion}/nokogiri-1.19.0
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    mkdir -p $dest/specifications
    cat > $dest/specifications/nokogiri-1.19.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "nokogiri"
  s.version = "1.19.0"
  s.summary = "nokogiri"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["nokogiri"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/nokogiri <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("nokogiri", "nokogiri", "1.19.0")
BINSTUB
    chmod +x $dest/bin/nokogiri
  '';
}
