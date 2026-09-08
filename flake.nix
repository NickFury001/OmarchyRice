{
  description = "My OS-agnostic system backup";

  inputs = {
    # Pull the bleeding-edge Nix packages
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Your custom application repositories go here!
    superfile.url = "github:yorukot/superfile";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    homeConfigurations."yourusername" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./home.nix ];
    };
  };
}
