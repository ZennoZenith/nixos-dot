{
  lib,
  config,
  ...
}: let
  service_name = "jellyfin";
in {
  options.custom.${service_name} = {
    enable = lib.mkEnableOption {
      description = "Enable Jellyfin";
      default = false;
    };

    user = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "";
      description = "Username";
    };
  };

  config = lib.mkIf config.custom.${service_name}.enable {
    services.jellyfin.enable = true;
    services.jellyfin.openFirewall = false;
    services.jellyfin.user = config.custom.${service_name}.user;
  };
}
