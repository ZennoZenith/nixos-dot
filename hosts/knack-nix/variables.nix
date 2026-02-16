{
  configurationName = "knacknix";

  ssh = {
    AllowUsers = [
      "knack"
      "zenith"
      "hadish"
      "remotebuild"
    ];
  };

  git = {
    name = "Know Knack";
    email = "201266042+knowknack@users.noreply.github.com";
  };

  gpg = {
    # Default/trusted key ID (helpful with throw-keyids)
    # Example, you will put your own keyid here
    # Use `gpg --list-keys`
    key = "99DCA16E0E956F82";

    ## `gpg --with-keygrip -K`
    keygrip = "539A9075E00CF0209656AF25C985596966F7516C";
  };

  home = {
    username = "knack";
    homeDirectory = "/home/knack";
    stateVersion = "25.11";
  };

  dotfiles = "/home/knack/nixos-dot/symlinks";
}
