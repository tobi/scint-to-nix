# overlays/better-sqlite3.nix — native SQLite3 binding for Node.js
{ pkgs, nodejs, ... }:
with pkgs;
{
  deps = [
    sqlite pkg-config python3
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [ darwin.cctools ];
  buildFlags = "--build-from-source";
}
