{ pkgs }:
let
  inherit (pkgs) callPackage;
in
{
  # Custom plugins
  # fFtT-highlights-nvim = callPackage ./startPlugins/fFtT-highlights-nvim.nix {};
  lazydev-nvim = callPackage ./startPlugins/lazydev-nvim.nix { };
  oil-nvim = callPackage ./startPlugins/oil-nvim.nix { };

  inherit (pkgs.vimPlugins)
    auto-session
    blink-cmp
    conform-nvim
    fzf-lua
    lualine-lsp-progress
    lualine-nvim
    lz-n
    nvim-autopairs
    nvim-lspconfig
    nvim-surround
    rainbow-delimiters-nvim

    colorful-menu-nvim
    luasnip
    nvim-highlight-colors
    snacks-nvim
    tiny-inline-diagnostic-nvim
    showkeys

    onedarkpro-nvim
    tokyonight-nvim
    nvim-web-devicons
    ;
}
