#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# charlock_holmes 0.7.9
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "charlock_holmes";
  version = "0.7.9";
  src = builtins.path {
    path = ./source;
    name = "charlock_holmes-0.7.9-source";
  };

  nativeBuildInputs = [ ruby ];

  buildPhase = ''
    extconfFlags=""
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      echo "Building extension in $dir"
      (cd "$dir" && ruby extconf.rb $extconfFlags && make -j$NIX_BUILD_CORES)
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
        mkdir -p $dest/gems/charlock_holmes-0.7.9
        cp -r . $dest/gems/charlock_holmes-0.7.9/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/charlock_holmes-0.7.9
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s charlock_holmes-0.7.9 $dest/gems/charlock_holmes-0.7.9-$gp
        ln -s charlock_holmes-0.7.9 $dest/extensions/${arch}/${rubyVersion}/charlock_holmes-0.7.9-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/charlock_holmes-0.7.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "charlock_holmes"
      s.version = "0.7.9"
      s.summary = "charlock_holmes"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/charlock_holmes-0.7.9-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "charlock_holmes"
      s.version = "0.7.9"
      s.platform = "$gp"
      s.summary = "charlock_holmes"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
  '';
}
