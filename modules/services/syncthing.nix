{...}: {
  # services.syncthing = {
  #   enable = true;
  #   openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
  #   dataDir = "/home/knack";
  #   # configDir = "/home/knack/.config/syncthing";
  #   user = "knack";
  #   group = "users";
  # };
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
    dataDir = "/home/zenith";
    # configDir = "/home/knack/.config/syncthing";
    user = "zenith";
    group = "users";
  };
  ## port 8384  is the default port to allow access from the network.
  # networking.firewall.allowedTCPPorts = [ 8384 ];
}
