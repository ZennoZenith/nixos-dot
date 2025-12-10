{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "tofi";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable tofi";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.tofi
    ];

    xdg.configFile."${name}/configA".text = ''
      width = 100%
      height = 100%
      border-width = 0
      outline-width = 0
      padding-left = 33%
      padding-top = 33%
      result-spacing = 25
      num-results = 5

      font = JetBrainsMono Nerd Font
      font-size = 24

      text-color = #4e4e5f

      prompt-text = " : "

      background-color = #11111bd9
      selection-color = #83A4E7
    '';

    xdg.configFile."${name}/configV".text = ''
      width = 100%
      height = 100%
      border-width = 0
      outline-width = 0
      padding-top = 33%
      padding-left = 10%
      padding-right = 10%
      result-spacing = 25
      num-results = 5

      font = JetBrainsMono Nerd Font
      font-size = 24

      text-color = #4e4e5f

      prompt-text = " : "

      background-color = #11111bd9
      selection-color =  #83A4E7
    '';
  };
}
