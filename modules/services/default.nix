{...}: {
  ## run `sudo tailscale up --auth-key=KEY`
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
  };
  ## port 8384  is the default port to allow access from the network.
  # networking.firewall.allowedTCPPorts = [ 8384 ];
}
