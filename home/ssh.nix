{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      linode = {
        host = "linode";
        hostname = "linode";
        port = 36965;
        user = "zenith";
        compression = true;
        addKeysToAgent = "yes";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/knack-linode";
        serverAliveInterval = 60;
        serverAliveCountMax = 10000;
      };
      zenith = {
        host = "zenith";
        hostname = "zenith";
        port = 22;
        user = "zenith";
        addKeysToAgent = "yes";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/knack_arch_zenith_arch";
        serverAliveInterval = 60;
        serverAliveCountMax = 10000;
      };
      github-zennozenith = {
        host = "github-zennozenith";
        hostname = "github.com";
        user = "git";
        addKeysToAgent = "yes";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/knack_arch_github_zennozenith";
      };
      github-knowknack = {
        host = "github-knowknack";
        hostname = "github.com";
        user = "git";
        addKeysToAgent = "yes";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/knack-github-knowknack";
      };
      github-meeran = {
        host = "github-meeran";
        hostname = "github.com";
        user = "git";
        addKeysToAgent = "yes";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/id_rsa";
      };
      github_dot_com = {
        host = "github.com";
        hostname = "github.com";
        user = "git";
        addKeysToAgent = "yes";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "~/.ssh/knack_arch_github_zennozenith";
      };
    };
  };
}
