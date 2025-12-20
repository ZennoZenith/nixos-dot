{
  lib,
  config,
  ...
}: let
  name = "sunshine";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable sunshine";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
