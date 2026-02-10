# ddtrace uses libdatadog gem's pkg-config at build time — not a system lib
{ pkgs, ruby }: {
  buildGems = [
    (pkgs.callPackage ../nix/gem/libdatadog { inherit ruby; })
  ];
}
