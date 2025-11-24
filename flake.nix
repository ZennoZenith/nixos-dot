{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    hl.url = "github:pamburus/hl";

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    disko,
    minegrub-theme,
    hl,
    alejandra,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.knacknix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        # {_module.args = {inherit inputs;};}
        ./hosts/default/configuration.nix

        minegrub-theme.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.knack = import ./hosts/default/home.nix;
            backupFileExtension = "HMbackup";
            extraSpecialArgs = {inherit inputs;};
          };
        }
        disko.nixosModules.disko
        {nixpkgs.config.allowUnfree = true;}

        (
          {...}: {
            environment.systemPackages = [
              hl.packages.${system}.bin
              alejandra.defaultPackage.${system}
            ];
          }
        )
      ];
    };
  };
}
