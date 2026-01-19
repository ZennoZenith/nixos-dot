{
  config,
  lib,
  pkgs,
  ...
}: {
  specialisation.on-the-go.configuration = {
    system.nixos.tags = ["on-the-go"];
    hardware.nvidia.prime = {
      offload = {
        enable = lib.mkForce true;
        enableOffloadCmd = lib.mkForce true;
      };
      sync.enable = lib.mkForce false;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics.enable = true;

  hardware.graphics.extraPackages = with pkgs; [
    mesa-demos
  ];

  hardware.nvidia = {
    ## package = config.boot.kernelPackages.nvidiaPackages.beta;
    ## package = config.boot.kernelPackages.nvidiaPackages.production;
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Default
    modesetting.enable = true;
    open = false;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    nvidiaSettings = true;

    ## `nix shell nixpkgs#pciutils -c lspci -D -d ::03xx`
    ## 0000:00:02.0 VGA compatible controller: Intel Corporation Kaby Lake-U GT2 [HD Graphics 620] (rev 02)
    ## 0000:01:00.0 3D controller: NVIDIA Corporation GM108M [GeForce 940MX] (rev a2)
    # PRIME sync and reverse sync modes are X11-only and do not work under Wayland.
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
