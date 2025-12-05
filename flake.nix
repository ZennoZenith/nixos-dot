{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.11";
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

    hyprland.url = "github:hyprwm/Hyprland";

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
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
    knacknixVariables = import ./hosts/knack-nix/variables.nix;
    zenithnixVariables = import ./hosts/zenith-nix/variables.nix;
  in {
    nixosConfigurations.knacknix = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        configurationName = "knacknix";
        variables = knacknixVariables;
      };
      system = "x86_64-linux";
      modules = [
        # {_module.args = {inherit inputs;};}
        ./hosts/knack-nix/configuration.nix

        minegrub-theme.nixosModules.default
        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.knack = import ./hosts/knack-nix/home.nix;
            backupFileExtension = "HMbackup";
            extraSpecialArgs = {
              inherit inputs;
              configurationName = "knacknix";
              variables = knacknixVariables;
            };
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
    nixosConfigurations.zenithnix = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        configurationName = "zenithnix";
        variables = zenithnixVariables;
      };
      system = "x86_64-linux";
      modules = [
        # {_module.args = {inherit inputs;};}
        ./hosts/zenith-nix/configuration.nix

        minegrub-theme.nixosModules.default
        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.zenith = import ./hosts/zenith-nix/home.nix;
            backupFileExtension = "HMbackup";
            extraSpecialArgs = {
              inherit inputs;
              configurationName = "zenithnix";
              variables = zenithnixVariables;
            };
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
