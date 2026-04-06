require("snacks").setup({
  quickfile = { enabled = true },

  input = {
    enabled = true,
    win = {
      on_win = function()
        vim.schedule(function()
          vim.cmd("stopinsert")
          vim.cmd("norm ^")
        end)
      end,
    },
  },

  indent = {
    enabled = true,

    -- scope = { enabled = false },
  },
})
