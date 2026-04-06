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

  # Language
  bash-language-server
  lua-language-server
  typescript-language-server
  shellcheck
  shfmt
  gcc
  clang
  clang-tools
  cmake
  ninja
  shellify

  # Comms Apps
  element-desktop # temporary matrix client
  nheko # also temporary matrix client
  signal-desktop
  thunderbird
  vesktop

  # Personal QOL (FOSS)
  joplin-desktop
  ungoogled-chromium
  dunst
  direnv
  grc
  gcr_4
  gtk3
  gtk4
  libreoffice
  wireshark
  swaybg
  obsidian
  pulseaudio
  pipewire
  helix
  alacritty
  ntfs3g
  pavucontrol
  nixfmt
  lld
  nil
  bun
  typescript-language-server
  nodejs_25
  firefox
  xdg-desktop-portal
  xwayland-satellite-unstable
  appimage-run
  fzf
  kdePackages.okular
  btop
  fastfetch
  dig
  tldr
  gemini-cli
  cloudflare-warp
  vlc
  obs-studio
  thunar
  ripgrep
  fd
  plocate
  bluetui
  android-tools
  wl-clipboard-rs
]
