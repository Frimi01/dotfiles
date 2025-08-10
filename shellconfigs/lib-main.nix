{ pkgs ? import <nixpkgs> {} }:

with pkgs;

{
  buildInputs = [
    nodejs_24
    nodePackages.typescript
    go
    jdk

    # build
    gradle 
    maven

    # language servers
    nodePackages.typescript-language-server
    nodePackages.prettier
    gopls
    jdt-language-server
    stylua

  ];

  shellHook = ''
    echo "Dev shell ready: all tools avalable!"
  '';
}

