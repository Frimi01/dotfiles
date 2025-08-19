{ pkgs ? import <nixpkgs> {} }:

let
  main = import ./lib-main.nix { inherit pkgs; };
  lwjgl = import ./lib-lwjgl.nix { inherit pkgs; };
in

pkgs.mkShell {
  name = "lwjgl-shell";

  buildInputs = main.buildInputs ++ lwjgl.buildInputs;

  shellHook = ''
    ${main.shellHook or ""}
    ${lwjgl.shellHook or ""}
  '';
}

