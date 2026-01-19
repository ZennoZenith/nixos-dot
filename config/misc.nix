{pkgs, ...}: {
  services.tuned.enable = true;
  services.upower.enable = true;

  services.logind = {
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";

    lidSwitch = "suspend";
    lidSwitchDocked = "ignore"; # optional: don't suspend if external monitor/docked
    lidSwitchExternalPower = "suspend"; # behavior when plugged in
  };

  # ## https://nixos.wiki/wiki/LogindJ
  # services.logind.settings.Login = {
  #   ## one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"
  #   HandleLidSwitch = "suspend";
  #   HandleLidSwitchExternalPower = "lock";
  #   HandleLidSwitchDocked = "suspend";

  #   HandlePowerKey = "suspend";
  # };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # services.getty.autologinUser = "knack";
  # services.tumbler.enable = true;
  # services.envfs.enable = true;
  # services.seatd.enable = true;
}
