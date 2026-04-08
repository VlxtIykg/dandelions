{
  pkgs,
  inputs,
  ...
}:
with pkgs;
[
  # Personal packages
  inputs.zen-browser.packages.${pkgs.system}.default
  inputs.self.packages.${pkgs.system}.bat
  inputs.self.packages.${pkgs.system}.mnw
  inputs.self.packages.${pkgs.system}.gitPC
  # inputs.self.packages.${pkgs.system}.cfwarp

  # Language
  bash-language-server
  shellcheck
  shfmt
  bun
  nodejs_25
  typescript-language-server
  gcc
  clang
  clang-tools
  cmake
  lld
  ninja
  nil
  nixfmt
  shellify
  lua-language-server

  # Comms Apps
  element-desktop # temporary matrix client
  nheko # also temporary matrix client
  signal-desktop
  thunderbird
  vesktop

  # Personal QOL (FOSS)
  joplin-desktop
  libreoffice
  kdePackages.okular

  # Browser
  ungoogled-chromium
  firefox

  # Apps I use
  dunst
  direnv
  grc
  gcr_4
  gtk3
  gtk4
  wireshark
  swaybg
  obsidian
  pulseaudio
  pipewire
  alacritty
  ntfs3g
  pavucontrol
  xdg-desktop-portal
  xwayland-satellite-unstable
  appimage-run
  bluetui
  obs-studio
  thunar

  # QOL
  btop
  fastfetch
  dig
  tldr
  fzf
  vlc
  ripgrep
  fd
  plocate
  android-tools
  wl-clipboard-rs # neovim dependency

  vesktop
  gemini-cli
  cloudflare-warp # warp-cli 2026.1.150.0 does not let me connect to the internet
  # or resolve to domains.
]
