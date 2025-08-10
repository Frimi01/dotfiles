{ pkgs ? import <nixpkgs> {} }:

let
  main = import ./lib-main.nix { inherit pkgs; };
in

pkgs.mkShell {
  name = "dev-shell";

  buildInputs = main.buildInputs;
  shellHook = main.shellHook;
}

