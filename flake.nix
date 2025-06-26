# flake.nix - Place this in your /etc/nixos/ directory
{
  description = "Jacob's NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Optional: Add more inputs for development
    # devenv.url = "github:cachix/devenv";
    # nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # Replace "nixos" with your actual hostname
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          
          # Integrate Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jacob = import ./home.nix;
            
            # Optionally, use extraSpecialArgs to pass arguments to home.nix
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
