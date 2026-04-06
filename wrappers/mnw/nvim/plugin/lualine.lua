require("lualine").setup({
  options = {
    theme = 'palenight',
    fmt = string.lower,
  },
  extensions = {
    "fzf",
    "fugitive", -- Will add later
  },

  sections = {
    -- lualine_b = {
    -- "branch",
    --  {
    --    "diagnostics",
    --    sources = { "nvim_diagnostic" },
    --  },
    -- },
    lualine_a = { "buffers", },
    -- lualine_b = { "mode" },
    lualine_b = {
      "mode",
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1,

        -- Don't show the full filepath if the file is in the nix store, since
        -- it'll be way too long
        fmt = function(filename)
          if filename:match("^/nix/store") then
            return vim.fn.expand("%:t")
          end
          return filename
        end,
      },
    },

    lualine_x = {
      {
        "lsp_status",
        icon = "",
        color = { fg = "Gray" },
      },
    },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },
})
