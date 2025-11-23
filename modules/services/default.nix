{...}: {
  ## run `sudo tailscale up --auth-key=KEY`
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  # systemd.services.myservice = {
  #   description = "My Service";
  #   serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -c 'echo hi'";
  #   wantedBy = [ "multi-user.target" ];
  # };

  ## Currently managed by home-manager
  #systemd.user.services.atuin = {
  #  description = "Atuin daemon";

  #  serviceConfig = {
  #    Type = "simple";
  #    ExecStart = "${pkgs.atuin}/bin/atuin daemon";
  #
  #    Restart = "on-failure";
  #    RestartSec = "5s";

  #  };

  #  wantedBy = [ "default.target" ];
  #};
}
