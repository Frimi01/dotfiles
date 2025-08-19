{ pkgs ? import <nixpkgs> {} }:

with pkgs;

{
  buildInputs = [
    openal
	flite
  ];
}
