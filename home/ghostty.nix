{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = true;

    settings = {
      theme = "Mathias";
      font-family = [
        "CaskaydiaCove Nerd Font Mono"
        "CaskaydiaMono Nerd Font"
      ];
      font-size = 12;
      background-opacity = "0.0";
      gtk-titlebar = false;
      fullscreen = false;
      window-padding-x = 1;
      window-padding-y = 1;
      command = "/usr/bin/env nu";
      bold-is-bright = true;
      cursor-style = "block";
      mouse-hide-while-typing = true;
      resize-overlay = "never";
      focus-follows-mouse = true;
      keybind = [
        "alt+shift+enter=toggle_fullscreen"
        "alt+left=unbind"
        "alt+right=unbind"
      ];
    };
  };
}
