{ pkgs, ... }:

{
  # Core settings
  home.username = "knack";
  home.homeDirectory = "/home/knack";
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    ghostty
    atuin
  ];

  home.file.".cargo/config.toml".source = ../configs/.cargo/config.toml;
  home.file.".config/jj".source = ../configs/jj;
  home.file.".config/fastfetch".source = ../configs/fastfetch;
  home.file.".config/glow".source = ../configs/glow;
  home.file.".config/mpd".source = ../configs/mpd;
  home.file.".config/rmpc".source = ../configs/rmpc;
  home.file.".config/omm".source = ../configs/omm;
  home.file.".config/zellij".source = ../configs/zellij;
  home.file.".config/waybar".source = ../configs/waybar;
  home.file.".config/tofi".source = ../configs/tofi;
  home.file.".config/starship".source = ../configs/starship;
}
