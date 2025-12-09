{
  lib,
  config,
  ...
}: let
  service_name = "syncthing";
in {
  options.custom.${service_name} = {
    enable = lib.mkEnableOption {
      description = "Enable Syncthing";
      default = false;
    };

    user = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "";
      description = "Username";
    };

    dataDir = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "/home/${config.custom.${service_name}.user}";
      description = "Data dir";
    };
  };

  config = lib.mkIf config.custom.${service_name}.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
      dataDir = config.custom.${service_name}.dataDir;
      # configDir = "/home/<user>/.config/syncthing";
      user = config.custom.${service_name}.user;
      group = "users";
    };
    ## port 8384  is the default port to allow access from the network.
    # networking.firewall.allowedTCPPorts = [ 8384 ];
  };
}
