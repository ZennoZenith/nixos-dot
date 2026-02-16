{variables, ...}: {
  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = false;
  services.jellyfin.user = variables.home.username;
}
