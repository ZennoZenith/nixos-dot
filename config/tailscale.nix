{...}: {
  ## run `sudo tailscale up --auth-key=KEY --advertise-exit-node`
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}
