{ pkgs ? import <nixpkgs> {} }:

let
  main = import ./lib-main.nix { inherit pkgs; };
  libgdx = import ./lib-libgdx.nix { inherit pkgs; };
in

pkgs.mkShell {
  name = "libgdx-shell";

  buildInputs = main.buildInputs ++ libgdx.buildInputs;

  shellHook = ''
    ${main.shellHook or ""}
    ${libgdx.shellHook or ""}
  '';
}

