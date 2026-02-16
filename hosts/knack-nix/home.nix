{
  inputs,
  config,
  variables,
  pkgs,
  ...
}: let
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink "${variables.dotfiles}/${path}";
in {
  ## TODO: # ssh -vT git@github-work

  imports = [
    inputs.zen-browser.homeModules.beta

    ../../config/home-manager/environment.nix
    ../../config/home-manager/gtk_qt.nix
    ../../config/home-manager/jujutsu.nix
    ../../config/home-manager/ns.nix
    ../../config/home-manager/programs.nix
    ../../config/home-manager/services.nix
    ../../config/home-manager/xdg.nix
  ];

  targets.genericLinux.gpu.nvidia.enable = true;

  ## for nixd package
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  home = {
    username = variables.home.username;
    homeDirectory = variables.home.homeDirectory;
    stateVersion = variables.home.stateVersion;
    shell.enableNushellIntegration = true;
    shell.enableFishIntegration = true;
    shell.enableBashIntegration = true;
  };

  # ── Bash ───────────────────────────────────────────────────────────────────
  home.file.".bashrc".source = create_symlink ".bashrc";

  # ── Git ────────────────────────────────────────────────────────────────────
  home.file."user.gitconfig".text = ''
    [user]
        name = "${variables.git.name}"
        email = "${variables.git.email}"
        signingKey = "${variables.gpg.key}"
  '';

  # ── Ssh ────────────────────────────────────────────────────────────────────
  home.file.".ssh/config".source = create_symlink "ssh/config";

  # ── Gnupg ──────────────────────────────────────────────────────────────────
  home.file.".gnupg/common.conf".source = create_symlink "gnupg/common.conf";
  home.file.".gnupg/gpg-agent.conf".source = create_symlink "gnupg/gpg-agent.conf";
  home.file.".gnupg/sshcontrol".text = variables.gpg.keygrip;
  home.file.".gnupg/gpg.conf".text = ''
    charset utf-8
    cert-digest-algo SHA512
    default-key 0x${variables.gpg.key}
    trusted-key 0x${variables.gpg.key}
    cert-digest-algo SHA512
    default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
    display-charset utf-8
    fixed-list-mode
    keyid-format 0xlong
    list-options show-uid-validity
    no-comments
    no-emit-version
    no-greeting
    no-symkey-cache
    personal-cipher-preferences AES256 AES192 AES
    personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed
    personal-digest-preferences SHA512 SHA384 SHA256
    require-cross-certification
    s2k-cipher-algo AES256
    s2k-digest-algo SHA512
    verify-options show-uid-validity
    with-fingerprint

  '';

  # ── Rust ───────────────────────────────────────────────────────────────────
  home.file.".cargo/config.toml".source = create_symlink ".cargo/config.toml";

  ## Symlink config files ─────────────────────────────────────────────────────
  xdg.configFile = builtins.listToAttrs (map (subpath: {
      name = subpath;
      value = {
        source = create_symlink subpath;
        recursive = true;
      };
    })
    [
      "scripts" ## Scripts

      "git"
      "bat"
      "hypr" ## Hyprland
      "helix"
      "fastfetch"
      "foot"
      "ghostty"
      "cava"
      "atuin"
      "glow"
      "htop"
      "kitty"
      "mpd"
      "nushell"
      "omm"
      "rmpc"
      "starship"
      "swayosd"
      "television"
      "tofi"
      "waybar"
      "wezterm"
      "yazi"
      "zed"
      "zellij"
      "bash"
    ]);

  home.packages = with pkgs; [
    ghostty
    atuin
    zathura
    evince
    seahorse

    nixd
    dprint
    ruff
    marksman
    markdown-oxide
    rumdl
    tailwindcss-language-server

    nushell
    nushellPlugins.desktop_notifications
    nushellPlugins.formats
    nushellPlugins.gstat
    nushellPlugins.highlight
    nushellPlugins.query
    nushellPlugins.skim
  ];
}
