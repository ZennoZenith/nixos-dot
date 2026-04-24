{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.11";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    # flake-utils.url = "github:numtide/flake-utils";

    hyprland.url = "github:hyprwm/Hyprland";

    ##https://wiki.hypr.land/Nix/Plugins/#hyprland-plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    ie-r.url = "github:miaupaw/ie-r";
    # omnix.url = "github:juspay/omnix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## TODO: Learn stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # alejandra = {
    #   url = "github:kamadorueda/alejandra/4.0.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    disko,
    minegrub-theme,
    stylix,
    # alejandra,
    ie-r,
    # omnix,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    commonOverlays = [
      nur.overlays.default

      (final: prev: {
        openldap = prev.openldap.overrideAttrs (_: {
          doCheck = false;
        });
      })

      (final: prev: {
        stable = import inputs.nixpkgs-stable {
          inherit (final) system;
          config.allowUnfree = true;
        };
      })
    ];

    commonModules = [
      {nixpkgs.overlays = commonOverlays;}

      minegrub-theme.nixosModules.default
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
      disko.nixosModules.disko

      ({pkgs, ...}: {
        environment.systemPackages = [
          # alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
          ie-r.packages.${pkgs.stdenv.hostPlatform.system}.default
          # omnix.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      })
    ];

    mkHost = {
      user,
      hostPath,
    }: let
      vars = import (hostPath + "/variables.nix");
    in
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          variables = vars;
        };

        modules =
          commonModules
          ++ [
            (hostPath + "/configuration.nix")

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.${user} = import (hostPath + "/home.nix");

                backupFileExtension = "HMbackup";

                extraSpecialArgs = {
                  inherit inputs;
                  variables = vars;
                };
              };
            }
          ];
      };
  in {
    nixosConfigurations = {
      knacknix = mkHost {
        user = "knack";
        hostPath = ./hosts/knack-nix;
      };

      zenithnix = mkHost {
        user = "zenith";
        hostPath = ./hosts/zenith-nix;
      };
    };
    # Code formatter
    # formatter.x86_64-linux = alejandra.defaultPackage.x86_64-linux;
  };
}
