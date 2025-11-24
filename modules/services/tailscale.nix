{...}: {
  ## run `sudo tailscale up --auth-key=KEY`
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}
