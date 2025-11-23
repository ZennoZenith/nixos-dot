{...}: {
  imports = [
    ./services/default.nix
    ./services/mpd.nix
    ./services/pueued.nix
  ];

  services = {
    logind.settings.Login.HandleLidSwitchDocked = "hybrid-sleep"; ## one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    getty.autologinUser = "knack";

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [
          "hsp_hs"
          "hsp_ag"
          "hfp_hf"
          "hfp_ag"
        ];
      };
    };

    openssh = {
      enable = true;
      settings = {
        # PasswordAuthentication = false;
        # KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [
          "knack"
          "zenith"
        ];
      };
    };
    fail2ban.enable = true;
  };
}
