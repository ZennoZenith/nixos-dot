{ pkgs, inputs, ... }:

{
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

    mimeApps = {
      enable = true;

      # defaultApplications = {
      #   "inode/directory" = [ "pcmanfm.desktop" ]; # Directories
      #   "text/plain" = [ "emacsclient.desktop" ]; # Plain text
      #   "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
      #     "onlyoffice-desktopeditors.desktop"
      #   ]; # .docx
      #   "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
      #     "onlyoffice-desktopeditors.desktop"
      #   ]; # .pptx
      #   "application/pdf" = [ "onlyoffice-desktopeditors.desktop" ]; # .pdf
      #   "application/zip" = [ "xarchiver.desktop" ];
      #   "text/*" = [ "emacsclient.desktop" ]; # Any text files
      #   "video/*" = [ "mpv.desktop" ]; # Any video files
      #   "x-scheme-handler/https" = [ "firefox.desktop" ]; # Links
      #   "x-scheme-handler/http" = [ "firefox.desktop" ]; # Links
      #   "x-scheme-handler/mailto" = [ "firefox.desktop" ]; # Links
      #   "image/*" = [ "feh.desktop" ]; # Images
      #   "image/png" = [ "feh.desktop" ];
      #   "image/jpeg" = [ "feh.desktop" ];
      # };
    };
  };

}

# [Default Applications]
# x-scheme-handler/http=zen.desktop
# x-scheme-handler/https=zen.desktop
# x-scheme-handler/chrome=zen.desktop
# text/html=zen.desktop
# application/x-extension-htm=zen.desktop
# application/x-extension-html=zen.desktop
# application/x-extension-shtml=zen.desktop
# application/xhtml+xml=zen.desktop
# application/x-extension-xhtml=zen.desktop
# application/x-extension-xht=zen.desktop
# x-scheme-handler/discord-831593107883032657=discord-831593107883032657.desktop
# x-scheme-handler/discord=vesktop.desktop
# image/png=imv.desktop
# image/jpeg=imv.desktop
# image/gif=imv.desktop
# image/webp=imv.desktop
# image/bmp=imv.desktop
# image/tiff=imv.desktop

# [Added Associations]
# x-scheme-handler/http=zen.desktop;
# x-scheme-handler/https=zen.desktop;
# x-scheme-handler/chrome=zen.desktop;
# text/html=zen.desktop;
# application/x-extension-htm=zen.desktop;
# application/x-extension-html=zen.desktop;
# application/x-extension-shtml=zen.desktop;
# application/xhtml+xml=zen.desktop;
# application/x-extension-xhtml=zen.desktop;
# application/x-extension-xht=zen.desktop;
