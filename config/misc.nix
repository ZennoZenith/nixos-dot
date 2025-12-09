{pkgs, ...}: {
  services.logind.settings.Login.HandleLidSwitchDocked = "hybrid-sleep"; ## one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  ## Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # services.getty.autologinUser = "knack";
  # services.tumbler.enable = true;
  # services.envfs.enable = true;
  # services.seatd.enable = true;
}
