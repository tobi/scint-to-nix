# mini_racer: V8 JavaScript engine bindings for Ruby
#
# Needs libv8-node at build time to get V8 headers and static library.
# The extconf.rb does:
#   gem 'libv8-node', '~> 24.1.0.0'
#   require 'libv8-node'
#   Libv8::Node.configure_makefile  # sets $INCFLAGS / $LDFLAGS from vendor/v8
#   create_makefile 'mini_racer_extension'
#
# We put the built libv8-node gem (which has vendor/v8 from nixpkgs' nodejs)
# on GEM_PATH so the default extconf + make flow works unmodified.
#
{ pkgs, ruby }:
let
  libv8-node = pkgs.callPackage ../nix/gem/libv8-node/24.1.0.0 {
    inherit ruby;
    pkgs = pkgs;
  };
in
{
  deps = [ ];
  beforeBuild = ''
    export GEM_PATH=${libv8-node}/${libv8-node.prefix}
  '';
}
