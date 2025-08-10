{ pkgs ? import <nixpkgs> {} }:

let
  main = import ./lib-main.nix { inherit pkgs; };
  systray = import ./lib-systray.nix { inherit pkgs; };
in

pkgs.mkShell {
  name = "systray-shell";

  buildInputs = main.buildInputs ++ systray.buildInputs;

  shellHook = ''
    ${main.shellHook or ""}
    ${systray.shellHook or ""}
  '';
}

