{ pkgs ? import <nixpkgs> {} }:

with pkgs;

{
  buildInputs = [
    pkg-config
    gtk3
    libayatana-appindicator
  ];
}
