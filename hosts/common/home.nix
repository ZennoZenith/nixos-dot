{
  inputs,
  pkgs,
  variables,
  config,
  ...
}: let
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    scripts = "scripts";
  };
in {
  imports = [
    inputs.zen-browser.homeModules.beta
    ## imports below DOES NOT have enable options
    ../../config/home-manager/hyprland.nix
    ../../config/home-manager/helix/default.nix
    ../../config/home-manager/ssh.nix

    ## imports below have enable options
    ../../config/home-manager/atuin.nix
    ../../config/home-manager/bash.nix
    ../../config/home-manager/bat.nix
    ../../config/home-manager/cava.nix
    ../../config/home-manager/fastfetch.nix
    ../../config/home-manager/ghostty.nix
    ../../config/home-manager/git.nix
    ../../config/home-manager/glow.nix
    ../../config/home-manager/go.nix
    ../../config/home-manager/gpg-agent.nix
    ../../config/home-manager/htop.nix
    ../../config/home-manager/jujutsu.nix
    ../../config/home-manager/keychain.nix
    ../../config/home-manager/kitty.nix
    ../../config/home-manager/mpd.nix
    ../../config/home-manager/nix-search-tv.nix
    ../../config/home-manager/nushell.nix
    ../../config/home-manager/omm.nix
    ../../config/home-manager/rmpc.nix
    ../../config/home-manager/starship.nix
    ../../config/home-manager/swayosd.nix
    ../../config/home-manager/television.nix
    ../../config/home-manager/tofi.nix
    ../../config/home-manager/waybar.nix
    ../../config/home-manager/wezterm.nix
    ../../config/home-manager/yazi.nix
    ../../config/home-manager/zed.nix
    ../../config/home-manager/zellij.nix
    ../../config/home-manager/zoxide.nix
    ../../config/home-manager/eza.nix
    ../../config/home-manager/rust.nix
    ../../config/home-manager/kde-connect.nix

    ## TODO: # ../../modules/home-manager/fzf.nix
  ];

  ## for nixd package
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  home = {
    username = variables.home.username;
    homeDirectory = variables.home.homeDirectory;
    stateVersion = variables.home.stateVersion;
    shell.enableNushellIntegration = true;
    shell.enableFishIntegration = true;
    shell.enableBashIntegration = true;

    # file.".cargo/config.toml".source = ../../symlinks/.cargo/config.toml;

    packages = with pkgs; [
      ghostty
      atuin
      zathura
      evince
      seahorse
    ];
  };

  custom = {
    jujutsu = {
      enable = true;
      name = variables.git.name;
      email = variables.git.email;
      gpgKey = variables.git.gpg.key;
    };
    git = {
      enable = true;
      name = variables.git.name;
      email = variables.git.email;
      gpgKey = variables.git.gpg.key;
    };

    atuin.enable = true;
    bash.enable = true;
    bat.enable = true;
    cava.enable = true;
    fastfetch.enable = true;
    ghostty.enable = true;
    glow.enable = true;
    gpg-agent.enable = true;
    htop.enable = true;
    keychain.enable = true;
    kitty.enable = true;
    mpd.enable = true;
    nix-search-tv.enable = true;
    nushell.enable = true;
    omm.enable = true;
    rmpc.enable = true;
    starship.enable = true;
    swayosd.enable = true;
    television.enable = true;
    tofi.enable = true;
    waybar.enable = true;
    wezterm.enable = true;
    yazi.enable = true;
    zed.enable = true;
    zellij.enable = true;
    zoxide.enable = true;
    eza.enable = true;
    rust.enable = true;
    kde-connect.enable = true;
  };

  programs.zen-browser.enable = true;

  targets.genericLinux.gpu.nvidia.enable = true;

  # Dracula theme configuration
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
      #package = pkgs.tokyonight-gtk-theme;
      #Dark (Blue Accent): "Tokyonight-Dark-B"
      #Dark (Moon Accent): "Tokyonight-Dark-Moon"
      #Storm (Gray/Muted Accent): "Tokyonight-Storm-B"
    };
    # Optional: uncomment for Dracula icons
    iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg = {
    /**
    ## configFile."fastfetch" = {
    ##   source = create_symlink "${dotfiles}/fastfetch/";
    ##   recursive = true;
    ## };
    */

    configFile =
      builtins.mapAttrs (name: subpath: {
        source = create_symlink "${variables.dotfiles}/${subpath}/";
        recursive = true;
      })
      configs;

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
      xdgOpenUsePortal = true;
    };

    /**
    ## To list all .desktop-files, run
    ##
    ## ls /run/current-system/sw/share/applications # for global packages
    ## ls /etc/profiles/per-user/$(id -n -u)/share/applications # for user packages
    ## ls ~/.nix-profile/share/applications # for home-manager packages
    */
    mimeApps = {
      enable = true;

      associations.added = {
        "image/jpeg" = ["imv.desktop"];
        "video/mp4" = ["mpv.desktop"];
        "application/pdf" = [
          "evince.desktop"
          "zathura.desktop"
        ]; # .pdf
      };

      defaultApplications = {
        "image/png" = ["imv.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "image/gif" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
        "image/bmp" = ["imv.desktop"];
        "image/tiff" = ["imv.desktop"];
        "image/*" = [
          "imv.desktop"
          "gimp.desktop"
        ];

        "inode/directory" = ["dolphin.desktop"]; # Directories
        "text/plain" = ["helix.desktop"]; # Plain text
        "text/*" = ["helix.desktop"]; # Any text files

        "application/pdf" = ["evince.desktop"]; # .pdf

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
      };
    };
  };
}
