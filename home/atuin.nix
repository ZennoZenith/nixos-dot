{...}: {
  programs.atuin = {
    enable = true;
    daemon.enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;

    settings = {
      theme.name = "marine";
      dialect = "uk";
      style = "full";
      inline_height = 25;
      invert = true;
      enter_accept = true;
      keymap_mode = "vim-insert";
      stats.ignored_commands = [
        "cd"
        "ls"
        "vi"
        "hx"
        "omm"
        "yazi"
        "y"
        "z"
        "uv"
        "paru"
        "pacman"
        "let"
      ];
      sync.record = true;
    };
  };
}
