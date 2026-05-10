{
  description = "NixOS configuration for ASUS TUF";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms.url = "github:AvengeMedia/DankMaterialShell";
  };

  outputs = { self, nixpkgs, home-manager, dms, ... }@inputs: {
    nixosConfigurations.TUF = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/tuf/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sillymamaco = {
            imports = [ ./home/desktop.nix ];
            _module.args = { inherit inputs; };
            home.stateVersion = "24.05";
          };
        }
      ];
    };
  };
}
