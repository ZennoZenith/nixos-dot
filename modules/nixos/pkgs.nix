{pkgs}:
with pkgs; [
  # https://github.com/JaKooLit/NixOS-Hyprland
  # lld
  # aim
  # jome
  # bibata-cursor-theme
  # crates-tui-git
  # https://github.com/muandane/goji
  # hl ## added in flake.nix
  # omm
  # timr-tui
  # clock-tui
  # rust-stakeholder

  ## Window Manager & Environment
  grimblast
  hypridle
  hyprlock
  hyprpaper
  hyprpicker
  hyprpolkitagent
  hyprsunset
  nwg-look
  rofi
  swww
  tofi
  walker
  waybar
  wlogout
  wofi
  xdg-desktop-portal-gtk
  # xdg-desktop-portal-hyprland
  # hyprlandPlugins.hypr-dynamic-cursors

  ## Shell & Terminal Utilities
  atuin
  carapace
  fish
  fzf
  keychain
  nushell
  starship
  tealdeer
  zoxide

  ## Terminal Applications
  alacritty
  bat
  bat-extras.batdiff
  bat-extras.batgrep
  bat-extras.batman
  bat-extras.batpipe
  bat-extras.batwatch
  bat-extras.prettybat
  csvlens
  eza
  fx
  ghostty
  glow
  helix
  kitty
  lazysql
  tailspin
  tree
  vivid
  yazi
  zellij

  ## Development & Version Control
  cargo
  clang
  delta
  gcc
  gh
  git
  git-cliff
  gitui
  go
  jujutsu
  lazygit
  meld
  mold
  rustup
  sccache
  tig
  uv
  zed-editor

  ## Search, Filter, and System Tools
  bandwhich
  btop
  dysk
  fastfetch
  fd
  gping
  igrep
  repgrep
  ripgrep
  ripgrep-all
  sd
  skim
  watchexec

  ## Nix & Configuration Tools
  nil
  nixd
  #nixfmt-rfc-style  ## replaced by "alejandra"
  stow

  ## Audio & Media
  imv
  mpd
  mpv
  pamixer
  pavucontrol
  pipewire
  playerctl
  rmpc
  vlc
  wireplumber

  ## Files, Archives & Misc
  age
  cliphist
  dua
  fclones
  gtrash
  kdePackages.dolphin
  kdePackages.qtsvg
  kdePackages.kdeconnect-kde
  kdePackages.kde-cli-tools
  kdePackages.kservice
  kdePackages.kio-fuse #to mount remote filesystems via FUSE
  kdePackages.kio-extras #extra protocols support (sftp, fish and more)
  kdePackages.qtkeychain

  ouch
  p7zip
  spacedrive
  wl-clipboard

  ## Utilities
  biome
  bitwarden-cli
  brightnessctl
  csvq
  difftastic
  discord
  dprint
  hurl
  jaq
  just
  kanata
  monolith
  mprocs
  oha
  pastel
  pueue
  qrtool
  superhtml
  taplo
  television
  topgrade
  wikiman
  xh
  yaak

  # Lesser Known/Specific Utilities
  andcli
  atac
  basalt
  bmm
  diffnav
  koji
  mergiraf
  pik
  rucola
  scooter
  serie
  serpl
  slumber
  uwsm
  syncthing
  dbeaver-bin
  mariadb
  libreoffice-fresh
  evince # pdf
  zathura ## pdf
  localsend
  file

  egl-wayland

  pyright
  ruff
  pyrefly
  seahorse ## Gui for OpenPGP
  pinentry-qt

  nixd
  obsidian
  systemctl-tui
  lazydocker

  # wine-staging
  wineWowPackages.staging
  # winetricks
  # wineWowPackages.waylandFull
  bottles
]
