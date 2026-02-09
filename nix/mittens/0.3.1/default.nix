# mittens 0.3.1
{ lib, stdenv, ruby, pkgs }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
  overlay = import ../../../overlays/mittens.nix { inherit pkgs ruby; };
  overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [];
  overlayBuildPhase = if builtins.isAttrs overlay && overlay ? buildPhase then overlay.buildPhase else null;
in

stdenv.mkDerivation {
  pname = "mittens";
  version = "0.3.1";
  src = builtins.path { path = ./source; name = "mittens-0.3.1-source"; };

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
    mkdir -p $dest/gems/mittens-0.3.1
    cp -r . $dest/gems/mittens-0.3.1/
    # Install compiled extensions
    local extdir=$dest/extensions/${arch}/${rubyVersion}/mittens-0.3.1
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    mkdir -p $dest/specifications
    cat > $dest/specifications/mittens-0.3.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "mittens"
  s.version = "0.3.1"
  s.summary = "mittens"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
