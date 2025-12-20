{
  lib,
  config,
  pkgs,
  ...
}: let
  name = "git";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable git";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      git-lfs-transfer
    ];

    programs.git.lfs.enable = true;
    programs.git.lfs.enablePureSSHTransfer = true;
  };
}
