{
  configurationName = "zenithnix";

  ssh = {
    AllowUsers = [
      "knack"
      "zenith"
      "hadish"
      "remotebuild"
    ];
  };

  git = {
    name = "Zenno Zenith";
    email = "95485961+ZennoZenith@users.noreply.github.com";
  };

  gpg = {
    # Default/trusted key ID (helpful with throw-keyids)
    # Example, you will put your own keyid here
    # Use `gpg --list-keys`
    key = "1CDCB4568D6A0051";

    ## `gpg --with-keygrip -K`
    keygrip = "A773ECC1671F32081FFD6893A18022553759159C";
  };

  home = {
    username = "zenith";
    homeDirectory = "/home/zenith";
    stateVersion = "25.11";
  };

  dotfiles = "/home/zenith/nixos-dot/symlinks";
}
