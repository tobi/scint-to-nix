# websocket-driver 0.8.0
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "websocket-driver";
  version = "0.8.0";
  src = builtins.path { path = ./source; name = "websocket-driver-0.8.0-source"; };

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
    mkdir -p $dest/gems/websocket-driver-0.8.0
    cp -r . $dest/gems/websocket-driver-0.8.0/
    # Install compiled extensions
    local extdir=$dest/extensions/${arch}/${rubyVersion}/websocket-driver-0.8.0
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    mkdir -p $dest/specifications
    cat > $dest/specifications/websocket-driver-0.8.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "websocket-driver"
  s.version = "0.8.0"
  s.summary = "websocket-driver"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
