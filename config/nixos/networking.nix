{variables, ...}: {
  networking = {
    hostName = variables.configurationName;
    networkmanager.enable = true;
    extraHosts = ''
      100.116.135.61  linode
      100.71.238.4    zenith
      100.71.238.4    remotebuilder
      100.75.63.27    knack
      129.212.244.40  digitalServer
    '';

    # firewall.allowedUDPPorts = [ ... ];
    # firewall.enable = false;
    firewall = rec {
      allowedTCPPorts = [
        22
        80
        443
      ];

      ## For kde connect
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
