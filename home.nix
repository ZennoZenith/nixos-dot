{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./home/default.nix
    ./home/bash.nix
    ./home/git.nix
    ./home/ghostty.nix
    ./home/atuin.nix
    ./home/bat.nix
    ./home/ssh.nix
    ./home/yazi.nix
    ./home/go.nix
    ./home/nix-search-tv.nix
  ];

  programs.zen-browser.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
    };
    theme = {
      name = "Awesthetic-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };

    ## To list all .desktop-files, run
    ##
    ## ls /run/current-system/sw/share/applications # for global packages
    ## ls /etc/profiles/per-user/$(id -n -u)/share/applications # for user packages
    ## ls ~/.nix-profile/share/applications # for home-manager packages
    mimeApps = {
      enable = true;

      defaultApplications = {
        "image/*" = ["imv.desktop"];
        "image/png" = ["imv.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "image/gif" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
        "image/bmp" = ["imv.desktop"];
        "image/tiff" = ["imv.desktop"];

        "inode/directory" = ["dolphin.desktop"]; # Directories
        "text/plain" = ["helix.desktop"]; # Plain text
        "text/*" = ["helix.desktop"]; # Any text files

        "application/zip" = ["xarchiver.desktop"];
        "text/html" = ["zen.desktop"]; # Any text files
        "video/*" = ["mpv.desktop"]; # Any video files

        "x-scheme-handler/https" = ["zen.desktop"]; # Links
        "x-scheme-handler/http" = ["zen.desktop"]; # Links
        "x-scheme-handler/mailto" = ["zen.desktop"]; # Links
        "x-scheme-handler/chrome" = ["zen.desktop"]; # Links
        "application/x-extension-htm" = ["zen.desktop"];
        "application/x-extension-html" = ["zen.desktop"];
        "application/x-extension-shtml" = ["zen.desktop"];
        "application/xhtml+xml" = ["zen.desktop"];
        "application/x-extension-xhtml" = ["zen.desktop"];
        "application/x-extension-xht" = ["zen.desktop"];

        # "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
        #   "onlyoffice-desktopeditors.desktop"
        # ]; # .docx
        # "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
        #   "onlyoffice-desktopeditors.desktop"
        # ]; # .pptx
        "application/pdf" = ["evince.desktop"]; # .pdf
      };
    };
  };
}
