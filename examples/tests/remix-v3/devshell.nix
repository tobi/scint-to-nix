{ pkgs ? import <nixpkgs> {}, nodejs ? pkgs.nodejs_22 }:
let
  project = import ../../nix/remix-v3.nix { inherit pkgs nodejs; };
in project.devShell {}
