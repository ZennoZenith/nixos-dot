{...}: {
  programs.keychain = {
    enable = true;

    keys = [
      "github"
      "knack"
      "linode"
      "zenith"
    ];

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };
}
