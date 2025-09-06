{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { # home manager
      inherit system;
      config.allowUnfree = true; 
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos/configuration.nix
        home-manager.nixosModules.default
      ];
    };

    homeConfigurations."frimi01@nixos" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./hosts/nixos/home.nix ];
    };
  };
}
