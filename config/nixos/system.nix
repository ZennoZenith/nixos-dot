{
  inputs,
  variables,
  pkgs,
  ...
}: {
  system = {
    autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-all"
        "nixpkgs"
        "-L" # print build logs
      ];
      dates = "07:00";
      randomizedDelaySec = "59min";
    };

    stateVersion = variables.home.stateVersion;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;

        # Define on which hard drive you want to install Grub.
        # no need to set devices, disko will add all device...
        # device = "/dev/sda"; # or "nodev" for efi only
        device = "nodev";

        minegrub-theme = {
          enable = true;
          splash = "100% Flakes!";
          background = "background_options/1.16 - [Nether Update].png";
          boot-options-count = 7;
        };
      };
    };
  };

  fileSystems."/mnt/whole" = {
    device = "/dev/disk/by-uuid/bc034754-5770-44e4-b606-2566262c567a";
    fsType = "btrfs";
    options = ["compress=zstd" "nofail" "noatime"];
  };

  fileSystems."/mnt/old-drive" = {
    device = "/dev/disk/by-uuid/ec062600-5190-4e73-b431-0edcbdaffea1";
    fsType = "btrfs";
    options = ["compress=zstd" "nofail" "noatime"];
  };

  i18n.defaultLocale = "en_US.UTF-8";
}
