{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "kde-connect";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable kde-connect";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    ## add in systemPackages
    ## pkgs.kdeconnect-kde

    services.kdeconnect.enable = true;
  };
}
