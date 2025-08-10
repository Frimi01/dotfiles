{ pkgs ? import <nixpkgs> {} }:

let
  runtimeLibs = with pkgs; lib.makeLibraryPath [
    glfw
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXrandr
    xorg.libXxf86vm
  ];
in {
  buildInputs = [
    pkgs.jdk17_headless
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${runtimeLibs}:$LD_LIBRARY_PATH
  '';
}
