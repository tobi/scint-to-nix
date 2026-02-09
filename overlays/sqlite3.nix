{ pkgs, ruby }: {
  deps = with pkgs; [ sqlite pkg-config ];
  buildPhase = ''
    cd ext/sqlite3
    ruby extconf.rb --enable-system-libraries
    make -j$NIX_BUILD_CORES
    cd ../..
    mkdir -p lib/sqlite3
    cp ext/sqlite3/sqlite3_native.so lib/sqlite3/
  '';
}
