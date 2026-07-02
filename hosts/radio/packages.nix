{
  pkgs,
  inputs,
  ...
}:
with pkgs;
[
  # Personal packages
  inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.bat
  inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.mnw
  inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.gitPC
  inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.mangowc
  # inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.cfwarp

  # Language
  bash-language-server
  shellcheck
  shfmt
  bun
  nodejs_26
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
  lua
  lua-language-server
  cargo-mommy
  rustup
  rustfmt
  rust-analyzer-unwrapped
  # rustdesk-flutter
  sqlite

  # Comms Apps
  # element-desktop # temporary matrix client
  nheko # also temporary matrix client
  signal-desktop
  thunderbird
  teams-for-linux

  # Personal QOL (FOSS)
  joplin-desktop
  libreoffice
  kdePackages.okular
  kdePackages.gwenview
  kdePackages.kdeconnect-kde
  # thorium-reader
  zip
  unzip
  ncdu

  # Browser
  ungoogled-chromium
  lynx
  # firefox

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
  pavucontrol
  alacritty
  xdg-desktop-portal
  xwayland-satellite-unstable
  appimage-run
  bluetui
  obs-studio
  thunar
  dnsmasq
  virt-manager
  libvirt
  feishin
  vicinae

  # QOL
  btop
  fastfetch
  dig
  tldr
  fzf
  (ffmpeg.override {
    withUnfree = true;
    withDebug = true;
  })
  vlc
  ripgrep
  fd
  plocate
  android-tools
  wl-clipboard-rs # neovim dependency
  oneko

  gemini-cli
  cloudflare-warp # warp-cli 2026.1.150.0 does not let me connect to the internet
  # or resolve to domains.

  # dependency
  xorg-server
  wlr-randr
  dconf
  nfs-utils
  ntfs3g
  gvfs
  guestfs-tools
  virtiofsd
  rpcbind
  # wev
  xev
]
