vim.diagnostic.config({ virtual_text = false })

require("tiny-inline-diagnostic").setup({
  options = {
    multilines = {
      enabled = true,
      always_show = true,
    },

    show_code = false,

    format = function(diag)
      local current_line = vim.fn.line(".")
      local diag_line = diag.lnum
      if diag_line + 1 == current_line then
        return diag.message
      end
      return diag.message:gmatch("[^\n]*")()
    end,
  },
})
