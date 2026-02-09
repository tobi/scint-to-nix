# racc 1.8.1
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "racc";
  version = "1.8.1";
  src = builtins.path { path = ./source; name = "racc-1.8.1-source"; };

  nativeBuildInputs = [ ruby ];

  buildPhase = ''
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
    mkdir -p $dest/gems/racc-1.8.1
    cp -r . $dest/gems/racc-1.8.1/
    # Install compiled extensions
    local extdir=$dest/extensions/${arch}/${rubyVersion}/racc-1.8.1
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    mkdir -p $dest/specifications
    cat > $dest/specifications/racc-1.8.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "racc"
  s.version = "1.8.1"
  s.summary = "racc"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["racc"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/racc <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("racc", "racc", "1.8.1")
BINSTUB
    chmod +x $dest/bin/racc
  '';
}
